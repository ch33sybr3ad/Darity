require 'rails_helper'

RSpec.describe Like, type: :model do
  it { should respond_to(:user) }
  it { should respond_to(:comment) }

  it 'should prevent duplicates' do
  	Like.create!(comment_id: 1, user_id: 1)
  	expect{
	  	Like.create!(comment_id: 1, user_id: 1)
  	}.to raise_error(ActiveRecord::RecordInvalid)
  end

end
