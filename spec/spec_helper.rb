require "porteiro"
require "porteiro/base"
require "pry"

class User < Struct.new(:name); end

class ControllerClass
  class << self
    attr_accessor :current_user, :params
  end
  self.current_user = User.new
  self.params = {controller: "document", action: "index"}

  include Porteiro 
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
