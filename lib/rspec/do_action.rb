require "rspec/do_action/version"
require "rspec"
require "active_support/concern"
require "active_support/callbacks"



module Rspec
  module DoAction
    extend ActiveSupport::Concern

    included do
      include ActiveSupport::Callbacks
      define_callbacks :do_action
    end

    def do_action
      expect(@action).to_not be_nil, "need define action block"
      run_callbacks :do_action do
        instance_eval &@action
      end
    end

    module ClassMethods
      def action(&block)
        before { @action = block }
      end

      def do_action(&block)
        action(&block) if block
        before { do_action }
      end

      def before_do_action(&block)
        set_callback :do_action, :before, &block
      end

      def after_do_action(&block)
        set_callback :do_action, :after, &block
      end

      def around_do_action(&block)
        set_callback :do_action, :around, &block
      end
    end
  end
end


RSpec.configure do |config|
  config.include Rspec::DoAction
end
