require 'test_helper'

class UserOpptiesControllerTest < ActionController::TestCase
  fixtures :users
  fixtures :oppties

  setup do
    @user=users(:user1)
    @oppty=oppties(:oppty1)
    @create={user_id: @user.id, oppty_id: @oppty.id}
    @request.env['HTTP_REFERER'] = oppty_path(@oppty.id)
  end

  test "should create user_oppty" do
    assert_difference('UserOppty.count') do
      post :create, @create
    end
    assert_redirected_to tasks_index_path

    assert_no_difference('UserOppty.count') do
      post :create, @create
    end
    assert_redirected_to oppty_path(@oppty.id)

    @create={}
    assert_no_difference('UserOppty.count') do
      post :create, @create
    end
    assert_redirected_to oppty_path(@oppty.id)
  end


end
