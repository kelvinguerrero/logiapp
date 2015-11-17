require 'test_helper'

class NaviesControllerTest < ActionController::TestCase
  setup do
    @navy = navies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:navies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create navy" do
    assert_difference('Navy.count') do
      post :create, navy: { name: @navy.name }
    end

    assert_redirected_to navy_path(assigns(:navy))
  end

  test "should show navy" do
    get :show, id: @navy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @navy
    assert_response :success
  end

  test "should update navy" do
    patch :update, id: @navy, navy: { name: @navy.name }
    assert_redirected_to navy_path(assigns(:navy))
  end

  test "should destroy navy" do
    assert_difference('Navy.count', -1) do
      delete :destroy, id: @navy
    end

    assert_redirected_to navies_path
  end
end
