require 'test_helper'

class HistoriesControllerTest < ActionController::TestCase
  setup do
    @history = histories(:history1)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: @history
    assert_response :success
  end
end
