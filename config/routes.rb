GithubReleases::Engine.routes.draw do
  get '/:id', to: 'releases#show'
  root 'releases#index'
end
