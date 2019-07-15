require "rspec/core"
require "rspec-do_action/version"

module Rspec
  module DoAction

    module InstanceMethods
      def do_action(*args)
        expect(action_proc).to_not be_nil, "need define action block"
        instance_exec *args, &action_proc
      end

      def invoke_do_action_once(example, force: false)
        return if !action_proc
        return if !force && skip_do_action?
        return if @do_action_once_invoked

        do_action(example)
        @do_action_once_invoked = true
      end

      def action_proc
        find_variable("@action_proc")
      end

      def skip_do_action?
        !!find_variable("@skip_do_action")
      end

      def find_variable(name)
        group = self.class.parent_groups.find { |group| group.instance_variable_defined?(name) }
        group.instance_variable_get(name) if group
      end
    end

    module ClassMethods
      def action(options = {}, &block)
        @skip_do_action = options[:skip]
        @action_proc = block
      end

      def do_action(options = {}, &block)
        @skip_do_action = false
        action(options, &block) if block
        before { |example| invoke_do_action_once(example, force: true) }
      end

      def skip_do_action
        @skip_do_action = true
      end
    end
  end
end

class RSpec::Core::Example
  def run_before_example_with_action(*args)
    run_before_example_without_action
    example_group_instance.send(:invoke_do_action_once, self, force: false)
  end

  if private_method_defined?(:run_before_example)
    alias_method :run_before_example_without_action, :run_before_example
    alias_method :run_before_example, :run_before_example_with_action
  else
    alias_method :run_before_example_without_action, :run_before_each
    alias_method :run_before_each, :run_before_example_with_action
  end
end

RSpec.configure do |config|
  config.include Rspec::DoAction::InstanceMethods
  config.extend Rspec::DoAction::ClassMethods
end
