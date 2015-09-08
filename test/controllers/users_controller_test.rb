require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:user1)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_no_difference('User.count') do
      post :create, user: { name: @user.name, password: 'secret', password_confirmation: 'secret', role: @user.role }
    end
    assert_redirected_to users_new_path
    @user.name="changed"
    assert_difference('User.count') do
      post :create, user: { name: @user.name, password: 'secret', password_confirmation: 'secret', role: @user.role }
    end
    assert_redirected_to sessions_new_path
  end

end
