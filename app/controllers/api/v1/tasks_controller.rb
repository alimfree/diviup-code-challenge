class Api::V1::TasksController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
    respond_with current_user.tasks
  end

  def show
    respond_with current_user.tasks.find(params[:id])
  end

  def create
    task = current_user.tasks.build(task_params)

    if task.save
      render json: task, status: 201, location: [:api, task]
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  def update
    task = current_user.tasks.find(params[:id])
    if task.update(task_params)
      render json: task, status: 200, location: [:api, task]
    else
      render json: { errors: task.errors }, status: 422
    end
  end

private

  def task_params
    params.require(:task).permit(:title, :description, :complete, :list_id)
  end
end
