require 'test_helper'

class CharityTest < ActiveSupport::TestCase

  def setup
    @charity = Charity.new(
      name: 'Ping Pong 4 Kids',
      url: 'http://pingpong.com',
      description: 'provides ping pong to poor and rich kids',
      picture_url: 'http://callsfreecalls.com/images/CFC_unique_charity.jpg')
  end

  test "charity should be valid" do
    assert @charity.valid?
  end



end
