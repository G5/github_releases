require 'rails/generators'

class GithubReleases::InstallGenerator < Rails::Generators::Base
  def mount_engine
    route "mount G5Header::Engine => '/releases'"
  end
end
