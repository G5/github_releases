Rails.application.routes.draw do
  mount GithubReleases::Engine => "/releases"
end
