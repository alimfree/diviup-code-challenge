require 'spec_helper'

class Authentication
  include Authenticable
end

describe Authenticable do
  let(:authentication) { Authentication.new } 
  subject { authentication }

  describe "#current_user" do
    before do
      @user = FactoryGirl.create :user
      request.headers["Authorization"] = @user.access_token
      authentication.stub(:request).and_return(request)
    end
    it "retrieves current user from authorization header" do
      expect(authentication.current_user.access_token).to eql @user.access_token
    end
  end

  describe "#authenticate_with_token" do
    before do
      @user = FactoryGirl.create :user
      authentication.stub(:current_user).and_return(nil)
      response.stub(:response_code).and_return(401)
      response.stub(:body).and_return({"errors" => "Not authenticated"}.to_json)
      authentication.stub(:response).and_return(response)
    end

    it "displays a json error" do
      expect(json_response[:errors]).to eql "Not authenticated"
    end

    it {  should respond_with 401 }
  end

  describe "#user_signed_in?" do
    context "successfully authenticates user and creates a session" do
      before do
        @user = FactoryGirl.create :user
        authentication.stub(:current_user).and_return(@user)
      end

      it { should be_user_signed_in }
    end

    context "Fails to authenticate user and start a session" do
      before do
        @user = FactoryGirl.create :user
        authentication.stub(:current_user).and_return(nil)
      end

      it { should_not be_user_signed_in }
    end
  end
end