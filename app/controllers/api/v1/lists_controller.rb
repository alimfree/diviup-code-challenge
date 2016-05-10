class Api::V1::ListsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def show
    respond_with current_user.lists.find(params[:id])
  end

  def index
    respond_with current_user.lists
  end
  
  def create
    list = current_user.lists.build(list_params) 
    if list.save
      render json: list, status: 201, location: [:api, list] 
    else
      render json: { errors: list.errors }, status: 422
    end
  end

  def destroy
    list = current_user.lists.find(params[:id]) 
    list.destroy
    head 204
  end

  private

  def list_params
    params.require(:list).permit(:title, :description) 
  end
end
