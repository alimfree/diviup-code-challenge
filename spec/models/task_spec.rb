require 'spec_helper'

describe Task do
  let(:task) { FactoryGirl.build :task }
  subject { task }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:complete) }

  it { should validate_presence_of(:title) }
  it { should belong_to :user }
  it { should belong_to :list }

end
