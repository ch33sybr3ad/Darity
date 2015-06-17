require 'rails_helper'

RSpec.describe GenerateDare, type: :model do
  it 'should reject without description' do
  	expect {
  		GenerateDare.create!
  	}.to raise_error(ActiveRecord::RecordInvalid)
  end
end
