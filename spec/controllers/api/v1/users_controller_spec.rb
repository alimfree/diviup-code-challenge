require 'spec_helper'

describe Api::V1::UsersController do

  before(:each) { request.headers['Accept'] = 'application/vnd.localhost.v1' }

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
    context "when successfully crreated" do
	  before(:each) do
	    @user_attributes = Factorygirl.attributes_for :user
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
	end
  end
end
