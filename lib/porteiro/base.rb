module Porteiro
  class Base
    
    def initialize(user, params)
      @user = user 
      @params = params 
    end
    attr_reader :user, :params
    
  end
end