require 'spec_helper'

describe Api::V1::ListsController do
  describe "GET #show" do
    before(:each) do
	  current_user = FactoryGirl.create :user
	  api_authorization_header current_user.auth_token
	  @list = FactoryGirl.create :list, user: current_user
	  get :show, user_id: current_user.id, id: @list.id
	end

    it "displays user list record by id" do
	  list_response = json_response[:list]
	  puts list_response
	  expect(list_response[:id]).to eql @list.id
    end

	it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
	  current_user = FactoryGirl.create :user
	  4.times { FactoryGirl.create :list, user: current_user }
	  api_authorization_header current_user.auth_token
	  get :index, user_id: current_user.id 
	end

	it "retrieves 4 records from databse" do
	  lists_response = json_response[:lists]
	  expect(lists_response).to have(4).items
	end

	it { should respond_with 200 }
  end
end
