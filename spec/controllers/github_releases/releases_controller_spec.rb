require 'spec_helper'

describe GithubReleases::ReleasesController do
  routes { GithubReleases::Engine.routes }

  let(:version) { { tag_name: 'v1.0.1' } }
  let(:versions) { { versions: [ version ] } }

  describe 'GET index' do
    subject(:request) { get :index }

    before do
      allow(GithubReleases).to receive(:releases).and_return(versions)
    end

    it 'calls releases on the Github class' do
      request
      expect(GithubReleases).to have_received(:releases)
    end

    specify { expect(request.status).to eq(200) }
    specify { expect(request.body).to eq(versions.to_json) }
  end

  describe 'GET show' do
    let(:id) { 'latest' }
    subject(:request) { get :show, id: id }

    before do
      allow(GithubReleases).to receive(:release).and_return(version)
    end

    it 'calls release on the Github class with an id' do
      request
      expect(GithubReleases).to have_received(:release).with(id)
    end

    specify { expect(request.status).to eq(200) }
    specify { expect(request.body).to eq(version.to_json) }
  end
end
