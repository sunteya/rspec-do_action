require "rspec"
require "active_support/core_ext/module"
require "active_support/concern"

require "rspec-do_action/version"

module Rspec
  module DoAction
    extend ActiveSupport::Concern

    def do_action
      expect(self.action).to_not be_nil, "need define action block"
      instance_eval &self.action
    end

    def do_action_once
      if !@do_action_once
        do_action
        @do_action_once = true
      end
    end

    def action
      group = self.class.parent_groups.find { |group| group.instance_variable_defined?("@action") }
      group.instance_variable_get("@action") if group
    end

    module ClassMethods
      def action(&block)
        @action = block
      end

      def do_action(&block)
        action(&block) if block
        before { do_action_once }
      end
    end
  end
end

class RSpec::Core::Example
  def run_before_each_with_action
    run_before_each_without_action
    example_group_instance.send(:do_action_once)
  end
  alias_method_chain :run_before_each, :action
end

RSpec.configure do |config|
  config.include Rspec::DoAction
end