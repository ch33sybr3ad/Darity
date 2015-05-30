require 'spec_helper'
require 'rails_helper'

RSpec.describe User, type: :model do

  let!(:user){
    FactoryGirl.create(:user)
  }

  it { should respond_to(:email) }

end
