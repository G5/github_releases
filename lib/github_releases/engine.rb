module GithubReleases
  class Engine < ::Rails::Engine
    isolate_namespace GithubReleases

    config.autoload_paths << GithubReleases::Engine.root.join('lib')
    config.generators { |g| g.test_framework :rspec }
  end

  class << self
    mattr_accessor :repo, :username, :github_api

    self.repo       = nil
    self.username   = nil
    self.github_api = 'https://api.github.com'
  end

  def self.setup(&block)
    yield self
  end
end
