require 'spec_helper'

describe GithubReleases do
  let(:response) { double(body: { 'tag_name' => tag_name }.to_json) }
  let(:tag_name) { 'v1.0.0' }
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

  describe '.refresh' do
    subject(:refresh) { described_class.refresh }

    before { refresh}

    it 'it writes the cache for all releases' do
      expect(Rails.cache).to have_received(:write).
        with(GithubReleases::RELEASES_KEY, parsed_response)
    end

    it 'it writes the cache for the latest release' do
      expect(Rails.cache).to have_received(:write).
        with("#{GithubReleases::RELEASE_KEY}-#{GithubReleases::LATEST_ID}", parsed_response)
    end
  end

  describe '.all' do
    let(:key) { GithubReleases::RELEASES_KEY }
    subject(:all) { described_class.all }

    context 'existing cache data' do
      before { Rails.cache.write(key, 'foo') }

      it 'reads the data from the cache' do
        all
        expect(Rails.cache).to have_received(:read).with(key)
      end
    end

    context 'no existing cache data' do
      before do
        Rails.cache.clear
        all
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

  describe '.find' do
    let(:id) { 'latest' }
    let(:key) { "#{GithubReleases::RELEASE_KEY}-#{id}" }

    subject(:find) { described_class.find(id) }

    context 'existing cache data' do
      before { Rails.cache.write(key, 'foo') }

      it 'reads the data from the cache' do
        find
        expect(Rails.cache).to have_received(:read).with(key)
      end
    end

    context 'no existing cache data' do
      before do
        Rails.cache.clear
        find
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

  describe '.find' do
    subject(:current_version) { described_class.current_version }

    before { described_class.stub(find: { 'tag_name' => tag_name }) }

    context 'overriden version number' do
      let(:custom_version) { 'staging' }

      before { stub_const('ENV', { 'CURRENT_VERSION' => custom_version }) }

      it 'returns version from the ENV var' do
        expect(current_version).to eq(custom_version)
      end
    end

    context 'no override' do
      it 'returns version from the API' do
        expect(current_version).to eq(tag_name)
      end
    end
  end
end
