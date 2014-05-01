require "porteiro"
require "porteiro/base"
require "pry"

class User < Struct.new(:name); end

class ControllerClass
  include Porteiro 

  def current_user
    User.new
  end
  
  def params
    @params ||= {controller: "document", action: "index"}
  end 
  
end


class ApplicationPolicy < Porteiro::Base


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
