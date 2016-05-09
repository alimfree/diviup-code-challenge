require 'spec_helper'

describe Task do
  let(:task) { FactoryGirl.build :task }
  subject { task }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:complete) }

  it { should validate_presence_of(:title) }
  it { should allow_value(true).for(:complete) }
  it { should allow_value(false).for(:complete) }
  it { should_not allow_value(nil).for(:complete) } 
  it { should belong_to :user }
  it { should belong_to :list }

end
