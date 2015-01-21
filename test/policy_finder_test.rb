require 'support/test_helper'
require 'support/test_controller'
require 'support/mock_user'
require 'support/comments_policy'
require 'porteiro/policy_finder'

module Porteiro
  describe PolicyFinder do 


    before do 
      @context = ::TestController.new(
        'comments', 
        'index', 
        {format: :json, action: 'index', controller: 'comments'}
      )
      @user = ::MockUser.new
      @policy_finder = PolicyFinder.new(@context, @user)
    end


    describe '#call' do 

      it 'finds policy by controller name' do 
        @policy_finder.call.must_be_instance_of ::CommentsPolicy
      end

    end

    describe '#policy_class_name' do 

      it 'returns the controller name concatenated with Policy' do 
        @policy_finder.policy_class_name.must_equal 'CommentsPolicy'
      end

      describe 'when controller is nested' do 

        it 'retains the class hierarchy' do 
          context = ::TestController.new(
            'comments', 
            'index', 
            {format: :json, action: 'index', controller: 'user/posts/comments'}
          )
          policy_finder = PolicyFinder.new(context, @user)
          policy_finder.policy_class_name.must_equal 'User::Posts::CommentsPolicy'
        end

      end

    end

    describe '#controller_name' do 

      it 'returns the controller name camelized' do 
        @policy_finder.controller_name.must_equal 'Comments'
      end

      describe 'when controller is nested' do 

        it 'retains the class hierarchy' do 
          context = ::TestController.new(
            'comments', 
            'index', 
            {format: :json, action: 'index', controller: 'user/posts/comments'}
          )
          @policy_finder = PolicyFinder.new(context, @user)
          @policy_finder.controller_name.must_equal 'User::Posts::Comments'
        end

      end

    end

    describe '#safe_constantize'do 

      it { @policy_finder.send(:safe_constantize, 'Object').must_equal Object }
      it { @policy_finder.send(:safe_constantize, 'Obbject').must_be_nil }
      
    end

  end
end