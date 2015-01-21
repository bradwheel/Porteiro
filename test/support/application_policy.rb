class ApplicationPolicy 
  
  def initialize(user, context)
    @user    = user 
    @context = context
  end

  def create?
    true
  end

end
