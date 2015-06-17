require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should respond_to(:dare) }
  it { should respond_to(:author) }
  it { should respond_to(:likes) }

  it 'should not be valid without body' do
  	expect {
  		Comment.create!
  	}.to raise_error(ActiveRecord::RecordInvalid)
  end
end
