require 'spec_helper'

describe GithubReleases::ReleasesController do
  routes { GithubReleases::Engine.routes }

  let(:tag_name) { 'v1.0.1' }
  let(:version) { { tag_name: tag_name } }
  let(:versions) { { versions: [ version ] } }

  describe 'GET index' do
    subject(:request) { get :index }

    before do
      allow(GithubReleases).to receive(:all).and_return(versions)
    end

    it 'calls releases on the Github class' do
      request
      expect(GithubReleases).to have_received(:all)
    end

    specify { expect(request.status).to eq(200) }
    specify { expect(request.body).to eq(versions.to_json) }
  end

  describe 'GET show' do
    let(:id) { 'latest' }
    subject(:request) { get :show, id: id }

    before do
      allow(GithubReleases).to receive(:find).and_return(version)
    end

    it 'calls release on the Github class with an id' do
      request
      expect(GithubReleases).to have_received(:find).with(id)
    end

    specify { expect(request.status).to eq(200) }
    specify { expect(request.body).to eq(version.to_json) }
  end

  describe 'GET current_version' do
    let(:expected_response) { { version: tag_name } }
    subject(:request) { get :current_version }

    before do
      allow(GithubReleases).to receive(:current_version).and_return(tag_name)
    end

    it 'calls release on the Github class with an id' do
      request
      expect(GithubReleases).to have_received(:current_version)
    end

    specify { expect(request.status).to eq(200) }
    specify { expect(request.body).to eq(expected_response.to_json) }
  end
end
