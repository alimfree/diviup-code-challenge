require 'api_constraints'

Divi::Application.routes.draw do
  devise_for :users
  # API definition
  namespace :api, defaults: { format: :json }, 
  					constraints: { subdomain: 'api' }, path: '/' do
	scope module: :v1 do
      # All API resources belong here
  	end
  end
end
