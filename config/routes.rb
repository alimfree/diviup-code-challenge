require 'api_constraints'

Divi::Application.routes.draw do
  devise_for :users
  # API definition
  namespace :api, defaults: { format: :json } do
	scope module: :v1 do
      # All API resources belong here
    resource :login, only: [:create], controller: :sessions
	  resources :users, :only => [:show, :create, :update, :destroy]
    resources :lists, :only => [:show, :index, :create, :update, :destroy]
    resources :tasks, :only => [:index, :show, :create, :update]
    resources :sessions, :only => [:create, :destroy]
    end
  end
end
