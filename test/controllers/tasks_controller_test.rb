require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  setup do
    @user_oppty = user_oppties(:userOppty1)
    @add={id:@user_oppty.id, status:DONE }
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should destroy opportunity" do
    assert_difference('UserOppty.count', -1) do
      delete :deleteOpportunity,:format => :json, :id=> @user_oppty.id
    end
    assert_equal "OK", response.body
    assert_no_difference('UserOppty.count') do
      delete :deleteOpportunity,:format => :json, :id=> ""
    end
    assert_equal "ERROR", response.body
  end

  test "update User Opportunity" do
    put :updateStatus,@add, :format=>:json
    assert_equal "OK", response.body
    @add={}
    put :updateStatus,@add, :format=>:json
    assert_equal "ERROR", response.body
  end

end
