require 'active_support/core_ext/string/inflections'

module Porteiro
  class PolicyFinder

    PolicyNotFound = Class.new(StandardError)

    def self.call(context, user, default_policy=nil)
      service = new(context, user, default_policy)
      service.call
    end

    attr_reader :context, :user, :default_policy
    def initialize(context, user, default_policy=nil)
      @context        = context
      @user           = user
      @default_policy = default_policy
    end

    def call
      policy.new(user, context)
    end

    def policy
      policy = safe_constantize(policy_class_name)
      if !policy && default_policy
        policy = safe_constantize(default_policy)
      end
      raise PolicyNotFound, "#{policy_class_name} could not be found" unless policy 
      policy 
    end

    def policy_class_name
      [controller_name, 'Policy'].join
    end

    def controller_name
      context.params[:controller].camelize
    end


    private

    def safe_constantize(name)
      ::Object.const_get(name.to_s)
    rescue ::NameError
      nil
    end

  end
end
