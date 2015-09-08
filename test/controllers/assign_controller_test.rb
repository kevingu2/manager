require 'test_helper'

class AssignControllerTest < ActionController::TestCase
  setup do
    @oppty=oppties(:oppty1)
  end
  test "should get index" do
    get :index
    assert_redirected_to invalid_entry_index_path
    get :index, :opptyId=>@oppty.id
    assert_response :success 
  end

end
