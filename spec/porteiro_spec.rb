require "spec_helper"

describe Porteiro do 

  let!(:current_user) {User.new}
  let!(:controller) {ControllerClass.new(current_user)}


  describe "#porteiro_user" do 

    it "returns the current_user" do 
      expect(controller.porteiro_user).to eq current_user
    end

  end

  describe "#policy" do 

    it "returns the instance of policy finder" do 
      expect(controller.policy.user).to eq(Porteiro.policy(controller.porteiro_user, controller.params).user)
      expect(controller.policy.params).to eq(Porteiro.policy(controller.porteiro_user, controller.params).params)
    end

  end

  describe "#default_policy" do 

    it "uses ApplicationPolicy as a default unless specified" do 
      expect(Porteiro.default_policy).to eq "ApplicationPolicy"
    end

    it "uses the specified default policy if supplied" do 
      Porteiro.default_policy=("SuppliedPolicy")
      expect(Porteiro.default_policy).to eq "SuppliedPolicy"
    end

  end

  describe Porteiro::PolicyFinder do 

    it "finds the correct policy from controller params" do 
      policy = Porteiro::PolicyFinder.new(controller.current_user, controller.params)
      expect(policy.klass).to eq "Document"
    end

    context "when policy doesn't exist" do 

      it "instantiates the default policy" do 
        Porteiro.default_policy = "ApplicationPolicy"
        policy = Porteiro::PolicyFinder.new(controller.current_user, controller.params).find!
        expect(policy).to be_instance_of(ApplicationPolicy)
      end

    end

    context "when policy does exist" do 

      
      before(:each) do 
        class DocumentPolicy < ApplicationPolicy; end
      end 

      it "instantiates the correct policy" do 
        policy = Porteiro::PolicyFinder.new(controller.current_user, controller.params).find!
        expect(policy).to be_instance_of(DocumentPolicy)
      end

    end

  end

  describe "#authorize_user_access!" do 

    context "when the action is permitted" do 

      it "returns true" do 
        expect(controller.authorize_user_access!).to be(true)
      end

    end

    context "when the action is not permitted" do 

      it "raises Porteiro::NotAuthorizedError" do 
        controller.params[:action] = "edit"
        expect {controller.authorize_user_access!}.to raise_error(Porteiro::NotAuthorizedError)
      end

    end

  end


  describe Porteiro::Base do 

    it "initializes with a user and request params" do 
      policy = Porteiro::Base.new(controller.current_user, controller.params)
      expect(policy.user).to eq controller.current_user
      expect(policy.params).to eq controller.params
    end

    it "#authorize_action!" do 
      policy = Porteiro::PolicyFinder.new(controller.current_user, controller.params).find!
      expect(policy.authorize_action!).to eq true
    end

  end

end