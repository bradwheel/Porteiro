class TestController 

  attr_reader :controller_name, :action_name, :params 
  
  def initialize(controller_name, action_name, params)
    @controller_name = controller_name
    @action_name = action_name
    @params = params
  end

  def current_user
    @current_user
  end

  def current_user=(user)
    @current_user = user
  end

  def other_user
    @other_user 
  end

  def other_user=(user)
    @other_user = user
  end
  
end
