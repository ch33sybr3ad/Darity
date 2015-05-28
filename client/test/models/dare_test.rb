require 'test_helper'

class DareTest < ActiveSupport::TestCase

  def setup
    @donation = Donation.new(
      pledger_id: 1,
      pledged_dare_id:1
    )
  end

  test "donation should be valid" do
    assert @donation.valid?
  end


end
