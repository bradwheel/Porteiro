require "porteiro"
require "pry"

class User < Struct.new(:name); end

class ControllerClass
  include Porteiro 

  attr_accessor :current_user

  def initialize(user)
    @current_user = user
  end
  
  def params
    @params ||= {controller: "document", action: "index"}
  end 
  
end


class ApplicationPolicy

  def initialize(user, params)
    @user = user 
    @params = params 
  end
  attr_reader :user, :params

  def index?
    true
  end

  def show?
    true
  end

  def edit?
    false
  end

end
