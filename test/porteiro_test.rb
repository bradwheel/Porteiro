require 'support/test_helper'
require 'support/comments_policy'
require 'support/application_policy'
require 'support/mock_user'

describe Porteiro do


  before do 
    ::TestController.include(Porteiro)
    @context = ::TestController.new(
      'comments', 
      'index', 
      {format: :json, action: 'index', controller: 'comments'}
    )
    @brad = ::MockUser.new('brad')
    @joe  = ::MockUser.new('joe')
    @context.current_user = @joe
    @context.other_user = @brad
  end


  describe '#porteiro_policy' do 

    it 'calls PolicyFinder with context and porteiro_user' do 
      mock = ::Minitest::Mock.new
      mock.expect(:call, nil, [@context, @joe, nil])

      Porteiro::PolicyFinder.stub(:call, mock) do 
        @context.stub(:porteiro_user, @joe) do 
          @context.porteiro_policy
        end
      end

      mock.verify
    end

  end  

  describe '#porteiro_action' do 

    it 'returns the action_name concatenated with ?' do 
      @context.porteiro_action.must_equal 'index?'
    end

    it 'returns the other action name when supplied' do 
      @context.porteiro_action('create').must_equal 'create?'
    end

  end

  describe '#porteiro_user' do 

    describe 'when porteiro_user is not set' do 
      
      it 'returns current_user' do 
        @context.porteiro_user.name.must_equal @joe.name
      end

    end

    describe 'when porteiro_user is defined' do 

      before do 
        @context.instance_eval do 
          def porteiro_user 
            other_user
          end
        end
      end

      it 'returns set user' do 
        @context.porteiro_user.name.must_equal @brad.name
      end

      after do 
        @context.instance_eval do 
          undef :porteiro_user
        end
      end

    end

  end

  describe '#authorize' do 
    
    describe 'when can access' do 

      it 'returns true' do
        @context.authorize!.must_equal true
      end

      describe 'when policy verification is not ran' do 
        
        it 'raises Porteiro::AuthorizationNotPerformed' do 
          proc { @context.verify_authorized }.must_raise Porteiro::AuthorizationNotPerformed
        end

      end

    end

    describe 'when cannot access' do 

      it 'raises Porteiro::ActionUnauthorized' do 
        context = ::TestController.new(
          'comments', 
          'create', 
          {format: :json, action: 'index', controller: 'comments'}
        )

        proc { context.authorize! }.must_raise Porteiro::UnauthorizedAction
      end

    end

  end

  describe 'policy default' do 

    before do 
      @context = ::TestController.new(
        'posts', 
        'create', 
        {format: :json, action: 'create', controller: 'posts'}
      )
    end

    describe 'when given a default policy' do 

      before do 
        @context.instance_eval do 
          def porteiro_default_policy
            '::ApplicationPolicy'
          end
        end   
      end

      it 'uses default' do    
        @context.authorize!.must_equal true
      end

      after do 
        @context.instance_eval do 
          undef :porteiro_default_policy
        end
      end

    end

    describe 'when not given a default policy' do

      it 'raises Porteiro::PolicyNotFound if not given' do 
        proc { @context.authorize! }.must_raise Porteiro::PolicyFinder::PolicyNotFound
      end

    end
    
  end

end
