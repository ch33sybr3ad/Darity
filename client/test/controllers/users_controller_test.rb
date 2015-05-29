require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:jason)
    @user2 = users(:darity)
  end

  test "should get index page" do
    get :index
    assert_response :success
  end

  test "should redirect after successfully logging in user" do
    log_in_as(@user)
    assert flash.empty?
    get :show, id: @user
    assert_response :success
  end

  test "user show page shows dares" do

  end

  test "user show page shows redirects to dares" do

  end


end
