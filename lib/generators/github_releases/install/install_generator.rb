require 'rails/generators'

class GithubReleases::InstallGenerator < Rails::Generators::Base
  def mount_engine
    route "mount GithubReleases::Engine => '/releases'"
  end
end
