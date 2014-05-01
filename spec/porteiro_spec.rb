require "spec_helper"

describe Porteiro do 

  describe "#default_policy" do 

    it "uses ApplicationPolicy as a default unless specified" do 
      expect(ControllerClass.default_policy).to eq "ApplicationPolicy"
    end

    it "uses the specified default policy if supplied" do 
      ControllerClass.default_policy=("SuppliedPolicy")
      expect(ControllerClass.default_policy).to eq "SuppliedPolicy"
    end

  end

  describe "#_find_policy" do 

    it "finds the correct policy from controller params" do 
      klass = ControllerClass.new._fetch_klass_from_params
      expect(klass).to eq "Document"
    end

    context "when policy doesn't exist" do 

      it "instantiates the default policy" do 
        ControllerClass.default_policy = "ApplicationPolicy"
        klass = ControllerClass.new._fetch_klass_from_params
        policy = ControllerClass.new._find_policy(klass)
        expect(policy).to be_instance_of(ApplicationPolicy)
      end

    end

    context "when policy does exist" do 

      before(:each) do 
        class DocumentPolicy < ApplicationPolicy; end
      end

      it "instantiates the correct policy" do 
        klass = ControllerClass.new._fetch_klass_from_params
        policy = ControllerClass.new._find_policy(klass)
        expect(policy).to be_instance_of(DocumentPolicy)
      end

    end

  end

  describe "#_load_porteiro_policy" do 

    it "loads the correct policy" do 
      policy = ControllerClass.new._load_porteiro_policy
      expect(policy).to be_instance_of(DocumentPolicy)
    end

  end

  describe "#authorize_user_access!" do 

    context "when the action is permitted" do 

      it "returns true" do 
        expect(ControllerClass.new.authorize_user_access!).to be(true)
      end

    end

    context "when the action is not permitted" do 

      it "raises Porteiro::NotAuthorizedError" do 
        controller = ControllerClass.new
        controller.params[:action] = "edit"
        expect {controller.authorize_user_access!}.to raise_error(Porteiro::NotAuthorizedError)
      end

    end

  end

end