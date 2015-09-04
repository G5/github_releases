namespace :github_releases do
  desc 'Refreshes the cached API calls'
  task refresh: :environment do
    GithubReleases.refresh
  end
end
