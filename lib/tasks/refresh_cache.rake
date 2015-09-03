namespace :github_releases do
  desc 'Refreshes the cached API calls'
  task refresh_cache: :environment do
    GithubReleases.refresh_cache
  end
end
