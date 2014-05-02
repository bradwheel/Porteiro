require "porteiro/version"
require "porteiro/policy_finder"
require "porteiro/base"
require "active_support/concern"
require "active_support/inflector"

module Porteiro
  extend ActiveSupport::Concern 

  class NotAuthorizedError < StandardError;end
  class PolicyUndefinedError < StandardError;end


  class << self

    ##
    # ClassMethod to find policy with PolicyFinder using the current_user 
    # and request params.
    ##

    def policy(user, req_params)
      policy = PolicyFinder.new(user, req_params).find!
      return policy
    end

    ##
    # Configuration methods for setting default policy name
    ## 

    def default_policy
      @default_policy ||= "ApplicationPolicy"
    end
    attr_writer :default_policy

  end

  ##
  # Before action that can be called in the controller to check for authorization.
  # If this is not called, no policy will be looked up.
  ## 

  def authorize_user_access!
    policy_obj = policy 
    controller_action = policy_obj.params.fetch(:action)
    policy_obj.send("#{controller_action}?") ? true :  (raise NotAuthorizedError, "You aren't permitted to access this resource")
  end

  def policy
    @policy || Porteiro.policy(porteiro_user, params)
  end

  def porteiro_user
    current_user
  end

end
