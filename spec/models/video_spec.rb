require 'spec_helper'
require 'rails_helper'

RSpec.describe Video, type: :model do

  it { should respond_to(:dare) }

  it 'should reject without url' do
    expect{Video.create!(
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      dare_id: (1..100).to_a.sample,
    )}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should reject without dare' do
    expect{Video.create!(
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      url: Faker::Internet.url
    )}.to raise_error(ActiveRecord::RecordInvalid)
  end

end
