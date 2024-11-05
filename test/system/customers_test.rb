require "application_system_test_case"

class CustomersTest < ApplicationSystemTestCase
  setup do
    @customer = customers(:one)
  end

  test "visiting the index" do
    visit main_customers_url
    assert_selector "h1", text: I18n.t(:customer, scope: %i[activerecord models], count: 2)
  end

  test "should create customer" do
    visit customers_url
    click_on "New customer"

    fill_in "Matriculation", with: @customer.matriculation
    fill_in "Name", with: @customer.name
    # fill_in "Password", with: @customer.password
    fill_in "Status", with: @customer.status
    click_on "Create Customer"

    assert_text "Customer was successfully created"
    click_on "Back"
  end

  test "should update Customer" do
    visit customer_url(@customer)
    click_on "Edit this customer", match: :first

    fill_in "Matriculation", with: @customer.matriculation
    fill_in "Name", with: @customer.name
    # fill_in "Password", with: @customer.password
    fill_in "Status", with: @customer.status
    click_on "Update Customer"

    assert_text "Customer was successfully updated"
    click_on "Back"
  end

  test "should destroy Customer" do
    visit customer_url(@customer)
    click_on "Destroy this customer", match: :first

    assert_text "Customer was successfully destroyed"
  end
end
