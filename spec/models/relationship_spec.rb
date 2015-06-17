require 'rails_helper'

RSpec.describe Relationship, type: :model do
	it { should respond_to(:follower) }
	it { should respond_to(:followee) }

	it 'should prevent duplicates' do
		Relationship.create!(followee_id: 1, follower_id: 2)
		expect {
			Relationship.create!(followee_id: 1, follower_id: 2)
		}.to raise_error(ActiveRecord::RecordInvalid)
	end
end
