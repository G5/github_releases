class GithubReleases::ReleasesController < GithubReleases::ApplicationController
  def index
    render json: GithubReleases.releases, status: 200
  end

  def show
    render json: GithubReleases.release(params[:id]), status: 200
  end
end
