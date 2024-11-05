require "test_helper"

class SaleTest < ActiveSupport::TestCase
  def setup
    @customer = Customer.create!(name: "CustomerTest", matriculation: "218921", status: "active")
  end

  test "should create a valid sale" do
    sale =  Sale.new(cart: "[{\"name\":\"Bala\",\"price\":\"0.25\",\"id\":1,\"quantity\":4},{\"name\":\"Diversos\",\"price\":\"0.50\",\"id\":2,\"quantity\":2}]", total_price: 2.00, customer: @customer)

    assert sale.valid?
  end

  test "should not create sale without customer" do
    sale = Sale.new(cart: "[{\"name\":\"Bala\",\"price\":\"0.25\",\"id\":1,\"quantity\":4},{\"name\":\"Diversos\",\"price\":\"0.50\",\"id\":2,\"quantity\":2}]", total_price: 2.00)

    assert_not sale.valid?
    assert_includes sale.errors[:customer], "must exist"
  end

  test "should not create sale without cart" do
    sale = Sale.new(total_price: 100.50, customer: @customer)

    assert_not sale.valid?
    assert_includes sale.errors[:cart], "can't be blank"
  end

  test "should not create sale without total_price" do
    sale = Sale.new(cart: "[{\"name\":\"Bala\",\"price\":\"0.25\",\"id\":1,\"quantity\":4},{\"name\":\"Diversos\",\"price\":\"0.50\",\"id\":2,\"quantity\":2}]", customer: @customer)

    assert_not sale.valid?
    assert_includes sale.errors[:total_price], "can't be blank"
  end

  test "should create sale with valid cart format" do
    sale = Sale.new(cart: "[{\"name\":\"Bala\",\"price\":\"0.25\",\"id\":1,\"quantity\":4},{\"name\":\"Diversos\",\"price\":\"0.50\",\"id\":2,\"quantity\":2}]", total_price: 150.75, customer: @customer)

    assert sale.valid?
  end

  test "should not create sale with invalid total_price (non-numerical)" do
    sale = Sale.new(cart: "[{\"name\":\"Bala\",\"price\":\"0.25\",\"id\":1,\"quantity\":4},{\"name\":\"Diversos\",\"price\":\"0.50\",\"id\":2,\"quantity\":2}]", total_price: "invalid_price", customer: @customer)

    assert_not sale.valid?
    assert_includes sale.errors[:total_price], "is not a number"
  end
end
