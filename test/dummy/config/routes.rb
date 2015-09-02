Rails.application.routes.draw do

  mount GithubReleases::Engine => "/github_releases"
end
