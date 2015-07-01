require 'test_helper'

class UserOpptiesControllerTest < ActionController::TestCase
  setup do
    @user_oppty = user_oppties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_oppties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_oppty" do
    assert_difference('UserOppty.count') do
      post :create, user_oppty: { oppty_id: @user_oppty.oppty_id, user_id: @user_oppty.user_id }
    end

    assert_redirected_to user_oppty_path(assigns(:user_oppty))
  end

  test "should show user_oppty" do
    get :show, id: @user_oppty
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_oppty
    assert_response :success
  end

  test "should update user_oppty" do
    patch :update, id: @user_oppty, user_oppty: { oppty_id: @user_oppty.oppty_id, user_id: @user_oppty.user_id }
    assert_redirected_to user_oppty_path(assigns(:user_oppty))
  end

  test "should destroy user_oppty" do
    assert_difference('UserOppty.count', -1) do
      delete :destroy, id: @user_oppty
    end

    assert_redirected_to user_oppties_path
  end
end
