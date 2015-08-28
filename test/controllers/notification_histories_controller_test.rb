require 'test_helper'

class NotificationHistoriesControllerTest < ActionController::TestCase
  setup do
    @notification_history = notification_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notification_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notification_history" do
    assert_difference('NotificationHistory.count') do
      post :create, notification_history: {  }
    end

    assert_redirected_to notification_history_path(assigns(:notification_history))
  end

  test "should show notification_history" do
    get :show, id: @notification_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notification_history
    assert_response :success
  end

  test "should update notification_history" do
    patch :update, id: @notification_history, notification_history: {  }
    assert_redirected_to notification_history_path(assigns(:notification_history))
  end

  test "should destroy notification_history" do
    assert_difference('NotificationHistory.count', -1) do
      delete :destroy, id: @notification_history
    end

    assert_redirected_to notification_histories_path
  end
end
