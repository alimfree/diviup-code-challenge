class Api::V1::SessionsController < ApplicationController
  respond_to :json

  def create 
	user_password = params[:session][:password]
	user_email = params[:session][:email]
	user = user_email.present? && User.find_by(email: user_email) 

  return invalid_login_attempt unless user
	if user.valid_password? user_password
	  sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end 
  end

  def destroy
    user = User.find_by(access_token: params[:id])    
    user.generate_authentication_token!
    user.save
    head 204
  end


  def invalid_login_attempt
      warden.custom_failure!
      render json: {error: t('invalid login attempt')}, status: :unprocessable_entity
  end
end
