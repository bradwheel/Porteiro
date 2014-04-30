module Porteiro
  class Base
    
    def initialize(user, params)
      @user = user 
      @params = params 
    end
    attr_reader :user, :params

    def authorize_action!
      controller_action = params.fetch(:action)
      self.send("#{controller_action}?") ? true :  (raise NotAuthorizedError, "You aren't permitted to access this resource")
    end

  end
end