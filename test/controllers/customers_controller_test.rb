require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get main_customers_url
    assert_response :success
  end

  test "should get new" do
    get new_main_customer_url
    assert_response :success
  end

  test "should create customer" do
    assert_difference("Customer.count") do
      post main_customers_url, params: { customer: { matriculation: @customer.matriculation, name: @customer.name, password: @customer.password, status: @customer.status } }
    end

    assert_redirected_to main_customer_url(Customer.last)
  end

  test "should show customer" do
    get main_customer_url(@customer)
    assert_response :success
  end

  test "should get edit" do
    get edit_main_customer_url(@customer)
    assert_response :success
  end

  test "should update customer" do
    patch main_customer_url(@customer), params: { customer: { matriculation: @customer.matriculation, name: @customer.name, password: @customer.password, status: @customer.status } }
    assert_redirected_to main_customer_url(@customer)
  end

  # test "should destroy customer" do
  #   assert_difference("Customer.count", -1) do
  #     delete main_customer_url(@customer)
  #   end

  #   assert_redirected_to main_customers_url
  # end

  test "should activate customer" do
    put activate_main_customer_path(@customer)
    assert_redirected_to main_customers_path
    @customer.reload
    assert_equal "active", @customer.status
  end

  test "should deactivate customer" do
    put deactivate_main_customer_path(@customer)
    assert_redirected_to main_customers_path
    @customer.reload
    assert_equal "inactive", @customer.status
  end
end
