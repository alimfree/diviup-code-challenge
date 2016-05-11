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
  it { should respond_to(:access_token) }
  it { should validate_uniqueness_of(:access_token) }
  it { should have_many(:lists) }

  describe "#generate_authentication_token!" do
    it "generates a unique auth token" do
	  Devise.stub(:friendly_token).and_return("uniquetoken")
	  @user.generate_authentication_token!
	  expect(@user.access_token).to eql "uniquetoken"
	end

	it "generates another token when user already exists and has previously authenticated" do 
	  existing_user = FactoryGirl.create(:user, access_token: "uniquetoken")
	  @user.generate_authentication_token!
	  expect(@user.access_token).not_to eql existing_user.access_token
	end
  end

  describe "#products association" do

    before do
	  @user.save
	  3.times { FactoryGirl.create :list, user: @user }
	end

	it "destroys the associated lists before destroying user" do
	  lists = @user.lists
	  @user.destroy
	  lists.each do |list|
	    expect(List.find(list)).to raise_error ActiveRecord::RecordNotFound
	  end
	end
  end
end
