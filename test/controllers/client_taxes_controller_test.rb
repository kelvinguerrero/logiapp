require 'test_helper'

class ClientTaxesControllerTest < ActionController::TestCase
  setup do
    @client_tax = client_taxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_taxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_tax" do
    assert_difference('ClientTax.count') do
      post :create, client_tax: { iva: @client_tax.iva, retefuente: @client_tax.retefuente, reteica: @client_tax.reteica }
    end

    assert_redirected_to client_tax_path(assigns(:client_tax))
  end

  test "should show client_tax" do
    get :show, id: @client_tax
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_tax
    assert_response :success
  end

  test "should update client_tax" do
    patch :update, id: @client_tax, client_tax: { iva: @client_tax.iva, retefuente: @client_tax.retefuente, reteica: @client_tax.reteica }
    assert_redirected_to client_tax_path(assigns(:client_tax))
  end

  test "should destroy client_tax" do
    assert_difference('ClientTax.count', -1) do
      delete :destroy, id: @client_tax
    end

    assert_redirected_to client_taxes_path
  end
end
