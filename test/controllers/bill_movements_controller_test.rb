require 'test_helper'

class BillMovementsControllerTest < ActionController::TestCase
  setup do
    @bill_movement = bill_movements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bill_movements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bill_movement" do
    assert_difference('BillMovement.count') do
      post :create, bill_movement: { total: @bill_movement.total, value: @bill_movement.value }
    end

    assert_redirected_to bill_movement_path(assigns(:bill_movement))
  end

  test "should show bill_movement" do
    get :show, id: @bill_movement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bill_movement
    assert_response :success
  end

  test "should update bill_movement" do
    patch :update, id: @bill_movement, bill_movement: { total: @bill_movement.total, value: @bill_movement.value }
    assert_redirected_to bill_movement_path(assigns(:bill_movement))
  end

  test "should destroy bill_movement" do
    assert_difference('BillMovement.count', -1) do
      delete :destroy, id: @bill_movement
    end

    assert_redirected_to bill_movements_path
  end
end
