require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  setup do
    @user_oppty = user_oppties(:userOppty1)
    @add={'id'=>@user_oppty.id, 'status'=>DONE }	
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should destroy writer's opportunity" do
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
    assert_no_difference('UserOppty.count') do
      put :updateStatus, :format=>:json, :id=>@add['id'], 
	      :status=>@add['status']
    end
    assert_equal DONE, UserOppty.find(@add['id']).status
    assert_equal "OK", response.body
    
    @new_add={status: TODO}
    assert_no_difference('UserOppty.count') do
       put :updateStatus, :format=>:json, :id=>@new_add['id'], 
	      :status=>@new_add['status']
    end
    assert_equal "ERROR", response.body
    assert_equal DONE, UserOppty.find(@add['id']).status
  end

end
