require 'spec_helper'


describe List do
  let(:list) { FactoryGirl.build :list }
  subject { list }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }

  it { should validate_presence_of :user_id }
end
