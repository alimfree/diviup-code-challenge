require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }



  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }
  it { should respond_to(:auth_token) }
  it { should validate_uniqueness_of(:auth_token) }

  describe "#generate_authentication_token!" do
    it "generates a unique auth token" do
	  Devise.stub(:friendly_token).and_return("uniquetoken")
	  @user.generate_authentication_token!
	  expect(@user.auth_token).to eql "uniquetoken"
	end

	it "generates another token when user already exists and has previously authenticated" do 
	  existing_user = FactoryGirl.create(:user, auth_token: "uniquetoken")
	  @user.generate_authentication_token!
	  expect(@user.auth_token).not_to eql existing_user.auth_token
	end
  end
end
