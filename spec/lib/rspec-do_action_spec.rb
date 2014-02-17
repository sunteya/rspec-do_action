require "spec_helper"
require "pry-nav"


describe Rspec::DoAction do
  subject(:result) { [] }

  describe "auto invoke after hooks" do
    before { result << 0 }
    action { result << 2 }
    before { result << 1 }
    it { should eq [ 0, 1, 2 ] }
  end

  describe "explicit invoke should before hooks" do
    do_action { result << 2 }
    before { result << 3 }
    it { should eq [ 2, 3 ] }
  end

  describe "nested example" do
    action { result << 2 }

    context "with override define" do
      action { result << 0 }
      it { should eq [ 0 ] }
    end
    
    context "with hooks" do
      before { result << 1 }
      it { should eq  [ 1 , 2 ] }
    end
  end

  describe "skip_do_action" do
    action { result << 2 }
    before { result << 1 }
    it { should eq [ 1, 2 ] }

    context "with nested example" do
      skip_do_action
      it { should eq [ 1 ] }
    end

    context "when invoke in example" do
      skip_do_action
      it { do_action; should eq [ 1, 2 ] }
    end
  end

end