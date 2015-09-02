module GithubReleases::Client
  def fetch(key, endpoint)
    return cache.read(key) if cache.exist?(key)
    cache.write(key, get(endpoint))
    cache.read(key)
  end

  private

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
