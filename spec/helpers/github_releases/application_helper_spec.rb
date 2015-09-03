require 'spec_helper'

describe GithubReleases::ApplicationHelper do
  describe '#current_version' do
    let(:tag_name) { 'v1.0.0' }
    let(:release) { { 'tag_name' => tag_name } }

    subject(:current_version) { helper.current_version }

    before { GithubReleases.stub(release: release) }

    it 'returns the tag name from the release' do
      expect(current_version).to eq(tag_name)
    end
  end
end
