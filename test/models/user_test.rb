require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(
    username: "Jordan",
    password: "captain_of_the_gopher_seas",
    email: "captain_of_the_gopher_seas@jordan.com",
    uid: 1234567890,
    provider: 'Twitter'
    )
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end


end
