require 'spec_helper'

describe Api::V1::TasksController do

  describe "GET #index" do
    before(:each) do
      current_user = FactoryGirl.create :user
      list = FactoryGirl.create :list
      api_authorization_header current_user.auth_token
      4.times { FactoryGirl.create :task, user: current_user, list: list }
      get :index, user_id: current_user.id
    end

    it "returns 4 task records from the user" do
      tasks_response = json_response[:tasks]
      expect(tasks_response).to have(4).items
    end

    it { should respond_with 200 }
  end

  describe "GET #show" do
    before(:each) do
      current_user = FactoryGirl.create :user
      list = FactoryGirl.create :list
      api_authorization_header current_user.auth_token
      @task = FactoryGirl.create :task, user: current_user, list: list
      get :show, user_id: current_user.id, id: @task.id
    end

    it "returns the user task record matching the id" do
      task_response = json_response[:task]
      expect(task_response[:id]).to eql @task.id
    end

    it { should respond_with 200 }
  end


  describe "POST #create" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.auth_token

      list = FactoryGirl.create :list
      task_params = { title: "Banana", description: "buy bananas", complete: false, list_id: list.id }
      post :create, user_id: current_user.id, task: task_params
    end

    it "returns newly created user task record" do
      task_response = json_response[:task]
      expect(task_response[:id]).to be_present
    end

    it { should respond_with 201 }
  end
end