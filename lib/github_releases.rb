require 'github_releases/engine'

module GithubReleases
  RELEASES_KEY = 'releases'
  RELEASE_KEY  = 'release'
  LATEST_ID    = 'latest'

  class << self
    def refresh_cache
      cache.write(RELEASES_KEY, get(endpoint))
      cache.write("#{RELEASE_KEY}-#{LATEST_ID}", get("#{endpoint}/#{LATEST_ID}"))
    end

    def releases
      fetch(RELEASES_KEY, endpoint)
    end

    def release(id)
      fetch("#{RELEASE_KEY}-#{id}", "#{endpoint}/#{id}")
    end

    private

    def fetch(key, resource)
      return cache.read(key) if cache.exist?(key)
      cache.write(key, get(resource))
      cache.read(key)
    end

    def get(resource)
      JSON.parse(HTTParty.get(resource, headers: headers).body)
    end

    def headers
      {
        'Content-Type'  => 'application/json',
        'Accept'        => 'application/vnd.github.v3+json',
        'User-Agent'    => GithubReleases.username,
        'Authorization' => "token #{ENV['GITHUB_API_TOKEN']}"
      }
    end

    def endpoint
      "#{GithubReleases.github_api}/repos/#{GithubReleases.username}/" \
        "#{GithubReleases.repo}/releases"
    end

    def cache
      Rails.cache
    end
  end
end
