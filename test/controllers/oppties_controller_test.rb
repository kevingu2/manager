require 'test_helper'

class OpptiesControllerTest < ActionController::TestCase
  setup do
    @oppty = oppties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:oppties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create oppty" do
    assert_difference('Oppty.count') do
      post :create, oppty: { ate: @oppty.ate, awardDate: @oppty.awardDate, captureMgr: @oppty.captureMgr, ed: @oppty.ed, idiqCA: @oppty.idiqCA, numWriters: @oppty.numWriters, on: @oppty.on, opptyId: @oppty.opptyId, opptyName: @oppty.opptyName, pWin: @oppty.pWin, programMgr: @oppty.programMgr, proposalMgr: @oppty.proposalMgr, rfpDate: @oppty.rfpDate, slComments: @oppty.slComments, sslArch: @oppty.sslArch, sslOrg: @oppty.sslOrg, status2: @oppty.status2, submitDate: @oppty.submitDate, technicalLead: @oppty.technicalLead, valid: @oppty.valid, value: @oppty.value }
    end

    assert_redirected_to oppty_path(assigns(:oppty))
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
    patch :update, id: @oppty, oppty: { ate: @oppty.ate, awardDate: @oppty.awardDate, captureMgr: @oppty.captureMgr, ed: @oppty.ed, idiqCA: @oppty.idiqCA, numWriters: @oppty.numWriters, on: @oppty.on, opptyId: @oppty.opptyId, opptyName: @oppty.opptyName, pWin: @oppty.pWin, programMgr: @oppty.programMgr, proposalMgr: @oppty.proposalMgr, rfpDate: @oppty.rfpDate, slComments: @oppty.slComments, sslArch: @oppty.sslArch, sslOrg: @oppty.sslOrg, status2: @oppty.status2, submitDate: @oppty.submitDate, technicalLead: @oppty.technicalLead, valid: @oppty.valid, value: @oppty.value }
    assert_redirected_to oppty_path(assigns(:oppty))
  end

  test "should destroy oppty" do
    assert_difference('Oppty.count', -1) do
      delete :destroy, id: @oppty
    end

    assert_redirected_to oppties_path
  end
end
