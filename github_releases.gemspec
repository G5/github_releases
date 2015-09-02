$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "github_releases/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "github_releases"
  s.version     = GithubReleases::VERSION
  s.authors     = ["bbauer"]
  s.email       = ["brian.bauer@g5platform.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of GithubReleases."
  s.description = "TODO: Description of GithubReleases."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
end
