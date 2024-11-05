require "test_helper"

class ProductTest < ActiveSupport::TestCase
  require "test_helper"

  class ProductTest < ActiveSupport::TestCase
    test "should create a valid product" do
      product = Product.new(name: "Example Product", description: "A short description", price: 10.99)

      assert product.valid?
    end

    test "should not create product without a name" do
      product = Product.new(description: "A short description", price: 10.99)

      assert_not product.valid?
      assert_includes product.errors[:name], "can't be blank"
    end

    test "should not create product without a description" do
      product = Product.new(name: "Example Product", price: 10.99)

      assert_not product.valid?
      assert_includes product.errors[:description], "can't be blank"
    end

    test "should not create product with a description longer than 50 characters" do
      product = Product.new(name: "Example Product", description: "A" * 51, price: 10.99)

      assert_not product.valid?
      assert_includes product.errors[:description], "is too long (maximum is 50 characters)"
    end

    test "should not create product without a price" do
      product = Product.new(name: "Example Product", description: "A short description")

      assert_not product.valid?
      assert_includes product.errors[:price], "can't be blank"
    end

    test "should not create product with a non-numerical price" do
      product = Product.new(name: "Example Product", description: "A short description", price: "not_a_number")

      assert_not product.valid?
      assert_includes product.errors[:price], "is not a number"
    end
  end
end
