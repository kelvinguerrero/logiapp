require 'test_helper'

class LogiBillsControllerTest < ActionController::TestCase
  setup do
    @logi_bill = logi_bills(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logi_bills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logi_bill" do
    assert_difference('LogiBill.count') do
      post :create, logi_bill: { name: @logi_bill.name, total: @logi_bill.total }
    end

    assert_redirected_to logi_bill_path(assigns(:logi_bill))
  end

  test "should show logi_bill" do
    get :show, id: @logi_bill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @logi_bill
    assert_response :success
  end

  test "should update logi_bill" do
    patch :update, id: @logi_bill, logi_bill: { name: @logi_bill.name, total: @logi_bill.total }
    assert_redirected_to logi_bill_path(assigns(:logi_bill))
  end

  test "should destroy logi_bill" do
    assert_difference('LogiBill.count', -1) do
      delete :destroy, id: @logi_bill
    end

    assert_redirected_to logi_bills_path
  end
end
