require 'spec_helper'

describe GithubReleases do
  let(:response) { double(body: { foo: 'bar' }.to_json) }
  let(:parsed_response) { JSON.parse(response.body) }
  let(:domain) { GithubReleases.github_api }
  let(:username) { GithubReleases.username }
  let(:repo) { GithubReleases.repo }
  let(:releases_endpoint) { "#{domain}/repos/#{username}/#{repo}/releases" }
  let(:headers) do
    {
      'Content-Type'  => 'application/json',
      'Accept'        => 'application/vnd.github.v3+json',
      'User-Agent'    => username,
      'Authorization' => "token #{ENV['GITHUB_API_TOKEN']}"
    }
  end

  before do
    allow(HTTParty).to receive(:get).and_return(response)
    allow(Rails.cache).to receive(:write)
    allow(Rails.cache).to receive(:read)
  end

  describe '.refresh_cache' do
    subject(:refresh_cache) { described_class.refresh_cache }

    before { refresh_cache }

    it 'it writes the cache for all releases' do
      expect(Rails.cache).to have_received(:write).
        with(GithubReleases::RELEASES_KEY, parsed_response)
    end

    it 'it writes the cache for the latest release' do
      expect(Rails.cache).to have_received(:write).
        with("#{GithubReleases::RELEASE_KEY}-#{GithubReleases::LATEST_ID}", parsed_response)
    end
  end

  describe '.releases' do
    let(:key) { GithubReleases::RELEASES_KEY }
    subject(:releases) { described_class.releases }

    context 'existing cache data' do
      before { Rails.cache.write(key, 'foo') }

      it 'reads the data from the cache' do
        releases
        expect(Rails.cache).to have_received(:read).with(key)
      end
    end

    context 'no existing cache data' do
      before do
        Rails.cache.clear
        releases
      end

      it 'calls the GithubReleases API with the appropriate parameters' do
        expect(HTTParty).to have_received(:get).with(releases_endpoint, headers: headers)
      end

      it 'writes the data to cache' do
        expect(Rails.cache).to have_received(:write).with(key, parsed_response)
      end

      it 'reads the data from the cache' do
        expect(Rails.cache).to have_received(:read).with(key)
      end
    end
  end

  describe '.release' do
    let(:id) { 'latest' }
    let(:key) { "#{GithubReleases::RELEASE_KEY}-#{id}" }

    subject(:release) { described_class.release(id) }

    context 'existing cache data' do
      before { Rails.cache.write(key, 'foo') }

      it 'reads the data from the cache' do
        release
        expect(Rails.cache).to have_received(:read).with(key)
      end
    end

    context 'no existing cache data' do
      before do
        Rails.cache.clear
        release
      end

      it 'calls the GithubReleases API with the appropriate parameters' do
        expect(HTTParty).to have_received(:get).
          with("#{releases_endpoint}/#{id}", headers: headers)
      end

      it 'writes the data to cache' do
        expect(Rails.cache).to have_received(:write).with(key, parsed_response)
      end

      it 'reads the data from the cache' do
        expect(Rails.cache).to have_received(:read).with(key)
      end
    end
  end
end
