class Api::V1::TasksController < ApplicationController

  before_action :authenticate_with_token!
  respond_to :json

  def index
    respond_with current_user.tasks
  end
end
