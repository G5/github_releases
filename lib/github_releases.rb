require 'github_releases/engine'
require 'github_releases/client'

module GithubReleases
  RELEASES_KEY = 'releases'
  RELEASE_KEY  = 'release'
  LATEST_ID    = 'latest'

  extend Client

  def self.refresh_cache
    cache.write(RELEASES_KEY, get(endpoint))
    cache.write("#{RELEASE_KEY}-#{LATEST_ID}", get("#{endpoint}/#{LATEST_ID}"))
  end

  def self.releases
    fetch(RELEASES_KEY, endpoint)
  end

  def self.release(id)
    fetch("#{RELEASE_KEY}-#{id}", "#{endpoint}/#{id}")
  end
end
