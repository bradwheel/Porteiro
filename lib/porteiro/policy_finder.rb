module Porteiro
  class PolicyFinder

    attr_reader :user, :req_params, :klass

    def initialize(user, req_params)
      @user = user
      @req_params = req_params
      @klass = fetch_klass_from_params
    end

    def find!
      begin 
        return instantiate_policy_class
      rescue NameError
        raise PolicyUndefinedError, "You must define your default policy: #{Porteiro.default_policy}"
      end
    end

    def fetch_klass_from_params
      return String(req_params.fetch(:controller).classify) rescue nil
    end

    ##
    # Finds policy and instantiates it. If policy doesn't exist, the default
    # policy is instantiated. This removes the need to define every policy if
    # you want to use method_missing in the default policy.
    ##

    def instantiate_policy_class
      policy = "#{klass}Policy".constantize.new(user, req_params) rescue nil
      return (Porteiro.default_policy.constantize.new(user, req_params)) unless policy 
      return policy 
    end

  end
end

