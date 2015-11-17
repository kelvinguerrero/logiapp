require 'test_helper'

class MiddlemenControllerTest < ActionController::TestCase
  setup do
    @middleman = middlemen(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:middlemen)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create middleman" do
    assert_difference('Middleman.count') do
      post :create, middleman: { name: @middleman.name, price: @middleman.price }
    end

    assert_redirected_to middleman_path(assigns(:middleman))
  end

  test "should show middleman" do
    get :show, id: @middleman
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @middleman
    assert_response :success
  end

  test "should update middleman" do
    patch :update, id: @middleman, middleman: { name: @middleman.name, price: @middleman.price }
    assert_redirected_to middleman_path(assigns(:middleman))
  end

  test "should destroy middleman" do
    assert_difference('Middleman.count', -1) do
      delete :destroy, id: @middleman
    end

    assert_redirected_to middlemen_path
  end
end
