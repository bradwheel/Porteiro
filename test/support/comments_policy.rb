class CommentsPolicy

  attr_reader :user, :context
  def initialize(user, context)
    @user   = user
    @context = context 
  end

  def index?
    true
  end

  def create?
    false
  end

  def update?
    false
  end
  
end
