$:.push File.expand_path('../lib', __FILE__)

require 'github_releases/version'

Gem::Specification.new do |s|
  s.name        = 'github_releases'
  s.version     = GithubReleases::VERSION
  s.authors     = ['bbauer']
  s.email       = ['brian.bauer@g5platform.com']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of GithubReleases.'
  s.description = 'TODO: Description of GithubReleases.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['rspec/**/*']

  s.add_dependency 'rails', '~> 4.1.0'
  s.add_dependency 'httparty'

  s.add_development_dependency 'rspec-rails'
end
