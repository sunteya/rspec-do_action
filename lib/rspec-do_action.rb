require "rspec/core"
require "rspec-do_action/version"

module Rspec
  module DoAction

    module InstanceMethods
      def do_action
        expect(action).to_not be_nil, "need define action block"
        instance_eval &action
      end

      def auto_do_action_once(force = false)
        return if find_variable("@skip_do_action")
        return if !force && action.nil?

        if !@auto_do_action_once
          do_action
          @auto_do_action_once = true
        end
      end

      def action
        find_variable("@action")
      end

      def find_variable(name)
        group = self.class.parent_groups.find { |group| group.instance_variable_defined?(name) }
        group.instance_variable_get(name) if group
      end
    end

    module ClassMethods
      def action(&block)
        @action = block
      end

      def do_action(&block)
        action(&block) if block
        before { auto_do_action_once(true) }
      end

      def skip_do_action
        @skip_do_action = true
      end
    end
  end
end

class RSpec::Core::Example
  def run_before_example_with_action
    run_before_example_without_action
    example_group_instance.send(:auto_do_action_once)
  end
  alias_method :run_before_example_without_action, :run_before_example
  alias_method :run_before_example, :run_before_example_with_action
end

RSpec.configure do |config|
  config.include Rspec::DoAction::InstanceMethods
  config.extend Rspec::DoAction::ClassMethods
end