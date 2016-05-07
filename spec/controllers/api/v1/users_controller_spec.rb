require 'spec_helper'

describe Api::V1::UsersController do

  describe "GET #show" do
    before(:each) do
	  @user = FactoryGirl.create :user
	  get :show, id: @user.id, format: :json
	end


	it "returns the reporter data on a hash" do
	  user_response = JSON.parse(response.body, symbolize_names: true)
	  expect(user_response[:email]).to eql @user.email
	end

	it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when successfully created" do
	  before(:each) do
	    @user_attributes = FactoryGirl.attributes_for :user
		post :create, { user: @user_attributes }, format: :json
	  end

      it "renders newly created user as json" do
	    user_response = JSON.parse(response.body, symbolize_names: true)
		expect(user_response[:email]).to eql @user_attributes[:email]
	  end

	  it { should respond_with 201 }
    end
	
	context "when creation fails" do
	  before(:each) do
	    # purposfully omitting required email
	    @invalid_user_attributes = { password: "12345678", password_confirmation: "12345678" } 
		post :create, { user: @invalid_user_attributes }, format: :json
	  end

	  it "renders an error" do
	    user_response = JSON.parse(response.body, symbolize_names: true)
		expect(user_response).to have_key(:errors)
      end

	  it "properly displays reason why user was not created" do
	    user_response = JSON.parse(response.body, symbolize_names: true)
		expect(user_response[:errors][:email]).to include "can't be blank"
	  end

	  it { should respond_with 422 }
	end
  end

  describe "PUT/PATCH #update" do
    context "when user is successfully updated" do
	  before(:each) do
	    @user = FactoryGirl.create :user
		patch :update, { id: @user.id, user: { email: "fake@google.com" } }, format: :json
      end

	  it "displays updated user as json" do
	    user_response = JSON.parse(response.body, symbolize_names: true)
		expect(user_response[:email]).to eql "fake@google.com"
	  end

	  it { should respond_with 200 }
	end

	context "when updating user failes" do
	  before(:each) do
	    @user = FactoryGirl.create :user
		# intentionally using improper email format
		patch :update, { id: @user.id, user: { email: "fail" } }, format: :json
	  end

	  it "displays an error" do
	    user_response = JSON.parse(response.body, symbolize_names: true)
		expect(user_response).to have_key(:errors)
	  end

	  it "displays why the user was not updated successfully" do
	    user_response = JSON.parse(response.body, symbolize_names: true)
		expect(user_response[:errors][:email]).to include "is invalid"
	  end

	  it { should respond_with 422 }
    end
  end	

  describe "DELETE #destroy" do
    before(:each) do
	  @user = FactoryGirl.create :user
	  delete :destroy, { id: @user.id }, format: :json
	end

	it { should respond_with 204 }
  end
end
