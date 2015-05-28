require 'test_helper'

class DonationTest < ActiveSupport::TestCase

  def setup
    @dare = Dare.new(
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
    )
  end

  test "dare should be valid" do
    assert @dare.valid?
  end


end
