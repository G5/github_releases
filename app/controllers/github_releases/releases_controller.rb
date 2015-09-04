class GithubReleases::ReleasesController < GithubReleases::ApplicationController
  def index
    render json: GithubReleases.all, status: 200
  end

  def show
    render json: GithubReleases.find(params[:id]), status: 200
  end

  def current_version
    render json: { version: GithubReleases.current_version }, status: 200
  end
end
