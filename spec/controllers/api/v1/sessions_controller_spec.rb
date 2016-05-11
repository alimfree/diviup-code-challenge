require 'spec_helper'

describe Api::V1::SessionsController do

  describe "POST #create" do

    before(:each) do
      @user = FactoryGirl.create :user
    end

    context "Successfully authenticates user when the credentials are correct" do

      before(:each) do
	    credentials = { email: @user.email, password: "12345678" }
	    post :create, { session: credentials }
      end

      it "returns the correct user when authentication is successful" do
        @user.reload
	    expect(json_response[:user][:access_token]).to eql @user.access_token
      end
      it { should respond_with 200 }
    end
 
    context "fails to authenticate when the credentials are invalid" do
      before(:each) do
	    credentials = { email: @user.email, password: "invalidpassword" }
	    post :create, { session: credentials }
      end
     
	  it "returns a json  error" do
	    expect(json_response[:errors]).to eql "Invalid email or password"
	  end
    
	  it { should respond_with 422 }
      end
    end

  describe "DELETE #destroy" do
	before(:each) do
	  @user = FactoryGirl.create :user
	  sign_in @user
	  delete :destroy, id: @user.access_token
	end
    it { should respond_with 204 }											
  end
end
