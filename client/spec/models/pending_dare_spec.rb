require 'rails_helper'
require 'spec_helper'

RSpec.describe PendingDare, type: :model do

  it { should respond_to(:proposer) }

end
