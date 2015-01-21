require 'porteiro/version'
require 'porteiro/policy_finder'

module Porteiro

  UnauthorizedAction = Class.new(StandardError) do 
    attr_accessor :user, :policy, :context
  end

  AuthorizationNotPerformed = Class.new(StandardError)

  def authorize!(other_action_name=nil)
    policy_authorized!
    policy        = porteiro_policy
    policy_action = porteiro_action(other_action_name)
    unless policy.public_send(policy_action)
      error = UnauthorizedAction.new("#{policy.class}: #{policy_action}")
      error.user, error.policy, error.context = porteiro_user, policy, policy_action
      raise error
    end
    true
  end

  def porteiro_policy
    PolicyFinder.call(
      self, 
      porteiro_user, 
      porteiro_default_policy
    )
  end

  def porteiro_action(other_action_name=nil)
    name = other_action_name || action_name
    [name.to_s, '?'].join
  end

  def porteiro_default_policy
  end

  def porteiro_user
    current_user
  end

  def verify_authorized
    raise AuthorizationNotPerformed unless @_porteiro_policy_authorized
  end

  def policy_authorized!
    @_porteiro_policy_authorized = true
  end

end
