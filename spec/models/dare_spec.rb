require 'spec_helper'
require 'rails_helper'

RSpec.describe Dare, type: :model do

  let!(:dare) {
    FactoryGirl.create(:dare)
  }

  it { should_not be_done }
  it { should respond_to(:donations) }
  it { should respond_to(:pledgers) }
  it { should respond_to(:video) }
  it { should respond_to(:daree) }
  it { should respond_to(:proposer) }

  it 'should reject without title' do
    expect{Dare.create!(
      description: Faker::Lorem.paragraph,
      daree_id: (1..100).to_a.sample,
      proposer_id: (1..100).to_a.sample,
      charity_id: (1..100).to_a.sample
    )}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should reject without description' do
    expect{Dare.create!(
      title: Faker::Lorem.sentence,
      daree_id: (1..100).to_a.sample,
      proposer_id: (1..100).to_a.sample,
      charity_id: (1..100).to_a.sample
    )}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should reject without daree' do
    expect{Dare.create!(
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      proposer_id: (1..100).to_a.sample,
      charity_id: (1..100).to_a.sample
    )}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should reject without proposer' do
    expect{Dare.create!(
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      daree_id: (1..100).to_a.sample,
      charity_id: (1..100).to_a.sample
    )}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should reject non-number price' do
    expect{Dare.create!(
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      daree_id: (1..100).to_a.sample,
      charity_id: (1..100).to_a.sample,
      price: 'faiourg'
    )}.to raise_error(ActiveRecord::RecordInvalid)
  end

end
