require 'spec_helper'
require 'rails_helper'

RSpec.describe Donation, type: :model do

  it { should respond_to(:dare) }
  it { should respond_to(:user) }
  it { should respond_to(:donation_amount) }

  it 'should reject without amount' do
    expect{Donation.create!(
      pledged_dare_id: (1..100).to_a.sample,
      pledger_id: (1..100).to_a.sample,
    )}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should reject with non-number amount' do
    expect{Donation.create!(
      pledged_dare_id: (1..100).to_a.sample,
      pledger_id: (1..100).to_a.sample,
      donation_amount: 'aiugb'
    )}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should reject without pledger' do
    expect{Donation.create!(
      pledged_dare_id: (1..100).to_a.sample,
      donation_amount: 10
    )}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should reject without dare' do
    expect{Donation.create!(
      pledger_id: (1..100).to_a.sample,
      donation_amount: 10
    )}.to raise_error(ActiveRecord::RecordInvalid)
  end

end
