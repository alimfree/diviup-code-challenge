class Api::V1::ListsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def show
    respond_with current_user.lists.find(params[:id])
  end

  def index
    respond_with current_user.lists
  end
end
