require "porteiro/version"
require "active_support/concern"
require "active_support/inflector"
require "pry"

module Porteiro
  extend ActiveSupport::Concern 

  class NotAuthorizedError < StandardError;end
  class PolicyUndefinedError < StandardError;end

  ##
  # Before action that can be called in the controller to check for authorization.
  # If this is not called, no policy will be looked up.
  ## 

  def authorize_user_access!
    policy = _load_porteiro_policy
    policy.authorize_action!
  end

  ## 
  # Find policy and initialize instance, rescuing the absence of a policy class 
  # by initializing the ApplicationPolicy class - which must be defined. 
  ##

  def _load_porteiro_policy
    klass = _fetch_klass_from_params
    return _find_policy(klass)
  end

  def _fetch_klass_from_params
    return String(params.fetch(:controller).classify)
  end

  def _find_policy(klass)
    begin 
      policy = "#{klass}Policy".constantize.new(current_user, params) rescue nil
      return (self.class.default_policy.constantize.new(current_user, params)) unless policy 
      return policy 
    rescue NameError
      raise PolicyUndefinedError, "You must define your default policy: #{default_policy}"
    end
  end


  module ClassMethods

    ##
    # Configuration methods for setting default policy name
    ## 

    def default_policy=(policy)
      @default_policy = policy 
    end

    def default_policy
      @default_policy ||= "ApplicationPolicy"
    end


  end
end
