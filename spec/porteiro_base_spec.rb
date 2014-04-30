require "spec_helper"

describe Porteiro::Base do 

  let(:current_user) { User.new }
  let(:params) { {controller: "document", action: "index"} }


  it "initializes with a user and request params" do 
    policy = Porteiro::Base.new(current_user, params)
    expect(policy.user).to eq current_user
    expect(policy.params).to eq params
  end

end