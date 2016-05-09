require 'spec_helper'

describe Api::V1::TasksController do

  describe "GET #index" do
    before(:each) do
      current_user = FactoryGirl.create :user
      list = FactoryGirl.create :list, user: current_user
      api_authorization_header current_user.auth_token
      4.times { FactoryGirl.create :task, user: current_user, list: list }
      get :index, user_id: current_user.id, list_id: list.id
    end

    it "returns 4 order records from the user" do
      tasks_response = json_response[:tasks]
      expect(tasks_response).to have(4).items
    end

    it { should respond_with 200 }
  end
end