require 'spec_helper'

describe Api::V1::TasksController do

  describe "GET #index" do
    before(:each) do
      current_user = FactoryGirl.create :user
      list = FactoryGirl.create :list
      api_authorization_header current_user.access_token
      4.times { FactoryGirl.create :task, user: current_user, list: list }
      get :index, user_id: current_user.id
    end

    it "returns 4 task records from the user" do
      tasks_response = json_response[:tasks]
      expect(tasks_response).to have(4).items
    end

    it "displays user along with each task" do
	  tasks_response = json_response[:tasks]
	  tasks_response.each do |task_response|
	    expect(task_response[:user]).to be_present
	  end
	end

    it "displays list  with each task" do								
	  tasks_response = json_response[:tasks]
	  tasks_response.each do |task_response|
	    expect(task_response[:list]).to be_present
      end
	end
  
    it { should respond_with 200 }
  end

  describe "GET #show" do
    before(:each) do
      current_user = FactoryGirl.create :user
      list = FactoryGirl.create :list
      api_authorization_header current_user.access_token
      @task = FactoryGirl.create :task, user: current_user, list: list
      get :show, user_id: current_user.id, id: @task.id
    end

    it "returns the user task record matching the id" do
      task_response = json_response[:task]
      expect(task_response[:id]).to eql @task.id
    end

	it "displays user as an embeded object" do
	  task_response = json_response[:task]
	  expect(task_response[:user][:email]).to eql @task.user.email
	end

    it "displays list as an embedded object" do
	  task_response = json_response[:task]
	  expect(task_response[:list][:title]).to eql @task.list.title
	end

    it { should respond_with 200 }
  end


  describe "POST #create" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.access_token

      list = FactoryGirl.create :list
      task_params = { title: "Banana", description: "buy bananas", complete: false, list_id: list.id }
      post :create, task: task_params
    end

    it "returns newly created user task record" do
      task_response = json_response[:task]
      expect(task_response[:id]).to be_present
    end

    it { should respond_with 201 }
  end


  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @task = FactoryGirl.create :task, user: @user
      api_authorization_header @user.access_token
    end

    context "when task updates successfully" do
      before(:each) do
        patch :update, { id: @task.id, task: { title: "apples", complete: true } }
      end

      it "renders the json representation for the updated user" do
        task_response = json_response[:task]
        expect(task_response[:title]).to eql "apples"
      end

      it { should respond_with 200 }
    end

    context "when task update fails" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @task.id, task: { complete: nil } }
      end

      it "displays an errors json" do
        task_response = json_response
        expect(task_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        task_response = json_response
        expect(task_response[:errors][:complete]).to include "is not included in the list"
      end

      it { should respond_with 422 }
    end
  end
end
