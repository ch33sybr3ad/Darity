require 'spec_helper'
require 'rails_helper'

RSpec.describe User, type: :model do

  let!(:user){
    FactoryGirl.create(:user)
  }

  it { should respond_to(:username) }
  it { should respond_to(:challenged_dares) }
  it { should respond_to(:proposed_dares) }
  it { should respond_to(:pledged_dares) }
  it { should respond_to(:donations) }

end
