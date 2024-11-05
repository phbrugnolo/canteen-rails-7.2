require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "should create a valid customer" do
    customer = Customer.new(name: "John Doe", matriculation: "782139")

    assert customer.valid?
  end

  test "should not create customer without a name" do
    customer = Customer.new(matriculation: "782139")

    assert_not customer.valid?
    assert_includes customer.errors[:name], "can't be blank"
  end

  test "should not create customer without matriculation" do
    customer = Customer.new(name: "John Doe")

    assert_not customer.valid?
    assert_includes customer.errors[:matriculation], "can't be blank"
  end

  test "should not create customer with duplicate matriculation" do
    Customer.create!(name: "Jane Doe", matriculation: "782139")
    duplicate_customer = Customer.new(name: "John Smith", matriculation: "782139")

    assert_not duplicate_customer.valid?
    assert_includes duplicate_customer.errors[:matriculation], "has already been taken"
  end
end
