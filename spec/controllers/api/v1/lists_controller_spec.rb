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
	  expect(list_response[:id]).to eql @list.id
    end

    it "displays user as an embeded object" do
      list_response = json_response[:list]
	  expect(list_response[:user][:email]).to eql @list.user.email
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

	it "displays user along with each list" do
      list_response = json_response[:lists]
	  list_response.each do |list_response|
	    expect(list_response[:user]).to be_present
      end
	end
      
	it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when list is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @list_attributes = FactoryGirl.attributes_for :list
        api_authorization_header user.auth_token 
        post :create, { list: @list_attributes }
      end

      it "displays the json representation for a newly created list record" do
        list_response = json_response[:list]
        expect(list_response[:title]).to eql @list_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user 
        # ommited list title
        @invalid_list_attributes = { description: "Groceries" } 
        api_authorization_header user.auth_token 
        post :create, { user_id: user.id, list: @invalid_list_attributes }
      end

      it "displays an errors json" do
        list_response = json_response
        expect(list_response).to have_key(:errors)
      end

      it "displays json errors on why list could not be created" do
        list_response = json_response
        expect(list_response[:errors][:title]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @list = FactoryGirl.create :list, user: @user
      api_authorization_header @user.auth_token 
      delete :destroy, { user_id: @user.id, id: @list.id }
    end

    it { should respond_with 204 }
  end
end
