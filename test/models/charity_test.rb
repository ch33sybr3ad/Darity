require 'test_helper'

class CharityTest < ActiveSupport::TestCase

  def setup
    @charity = Charity.new(
      name: 'Ping Pong 4 Kids',
      url: 'http://pingpong.com',
      mission: 'provides ping pong to poor and rich kids',
      transparency_score: "90")
  end

  test "charity should be valid" do
    assert @charity.valid?
  end



end
