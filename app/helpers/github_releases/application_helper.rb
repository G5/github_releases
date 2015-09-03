module GithubReleases
  module ApplicationHelper
    def current_version
      GithubReleases.release('latest')['tag_name']
    end
  end
end
