require 'test_helper'

class OpptiesControllerTest < ActionController::TestCase
  setup do
    @oppty = oppties(:one)
  end

  test "should show oppty" do
    get :show, id: @oppty
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @oppty
    assert_response :success
  end

  test "should update oppty" do
    patch :update, id: @oppty,
          oppty: {slDir:@oppty.slDir,
                  leadEstim: @oppty.leadEstim,
                  engaged:@oppty.engaged,
                  solution:@oppty.solution,
                  estimate:@oppty.estimate,
                  slArch:@oppty.slArch,
                  slComments: @oppty.slComments,
                  coordinate: @oppty.coordinate}
    assert_redirected_to oppty_path(assigns(:oppty))
   end

end
