$:.push File.expand_path('../lib', __FILE__)

require 'github_releases/version'

Gem::Specification.new do |s|
  s.name        = 'github_releases'
  s.version     = GithubReleases::VERSION
  s.authors     = ['Brian Bauer']
  s.email       = ['brian.bauer@g5platform.com']
  s.homepage    = 'https://rubygems.org/gems/github_releases'
  s.summary     = 'Exposes an apps Github releases and current version'
  s.description = 'Exposes an apps Github releases and current version'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['rspec/**/*']

  s.add_dependency 'rails', '~> 4.1.0'
  s.add_dependency 'httparty'
  s.add_dependency 'sqlite3'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'pry'
end
