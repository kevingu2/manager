require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
  test "should logout" do
    get :destroy
    assert_redirected_to sessions_new_path 
  end

end
