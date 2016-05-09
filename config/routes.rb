require 'api_constraints'

Divi::Application.routes.draw do
  devise_for :users
  # API definition
  namespace :api, defaults: { format: :json }, 
  					constraints: { subdomain: 'api' }, path: '/' do
	scope module: :v1 do
      # All API resources belong here
	  resources :users, :only => [:show, :create, :update, :destroy] do
        resources :lists, :only => [:show, :index, :create, :update, :destroy]
        resources :tasks, :only => [:index, :show]
	  end
      resources :sessions, :only => [:create, :destroy]
    end
  end
end
