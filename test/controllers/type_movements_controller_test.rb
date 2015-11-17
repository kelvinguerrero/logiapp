require 'test_helper'

class TypeMovementsControllerTest < ActionController::TestCase
  setup do
    @type_movement = type_movements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:type_movements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create type_movement" do
    assert_difference('TypeMovement.count') do
      post :create, type_movement: { name: @type_movement.name }
    end

    assert_redirected_to type_movement_path(assigns(:type_movement))
  end

  test "should show type_movement" do
    get :show, id: @type_movement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @type_movement
    assert_response :success
  end

  test "should update type_movement" do
    patch :update, id: @type_movement, type_movement: { name: @type_movement.name }
    assert_redirected_to type_movement_path(assigns(:type_movement))
  end

  test "should destroy type_movement" do
    assert_difference('TypeMovement.count', -1) do
      delete :destroy, id: @type_movement
    end

    assert_redirected_to type_movements_path
  end
end
