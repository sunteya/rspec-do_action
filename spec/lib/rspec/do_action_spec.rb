require "spec_helper"

describe Rspec::DoAction do
  subject(:result) { [] }
  
  describe "action syntax" do
    action { result << 1 }
    it { should eq [] }

    context 'with do_action' do
      do_action
      
      it { should eq [ 1 ]}
    end
  end

  describe "do_action syntax" do
    do_action { result << 1 }
    it { should eq [ 1 ] }
  end

  describe "do_action callback" do
    do_action { result << 1 }
    before_do_action { result << 0 }
    after_do_action { result << 2 }

    it { should eq [ 0, 1, 2 ] }
  end
end