GithubReleases::Engine.routes.draw do
  get '/current_version', to: 'releases#current_version'
  get '/:id', to: 'releases#show'
  root 'releases#index'
end
