# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Product.create([
  {
    name: "Bala",
    description: "7belo",
    status: "active",
    price: 0.25,
    image: Rails.root.join("app/assets/images/img-product.png")
  },
  {
    name: "RTX 4090",
    description: "roda td",
    status: "inactive",
    price: 13000,
    image: Rails.root.join("app/assets/images/img-product.png")
  },
  {
    name: "Diversos",
    description: "diverso",
    status: "active",
    price: 0.50,
    image: Rails.root.join("app/assets/images/img-product.png")
  }
])

Customer.create([
  {
    name: "Joao",
    matriculation: "123456",
    status: "active",
    password: "123456",
    image: Rails.root.join("app/assets/images/img-perfil.png")
  },
  {
    name: "Pedro",
    matriculation: "654321",
    status: "active",
    password: "123456",
    image: Rails.root.join("app/assets/images/img-perfil.png")
  },
  {
    name: "Teste",
    matriculation: "1456789",
    status: "inactive",
    password: "123456",
    image: Rails.root.join("app/assets/images/img-perfil.png")
  }
])

Sale.create([
  {
    customer_id: 1,
    cart: "[{\"name\":\"Bala\",\"price\":\"0.25\",\"id\":1,\"quantity\":4},{\"name\":\"Diversos\",\"price\":\"0.50\",\"id\":2,\"quantity\":2}]",
    total_price: 2.00
  }
])
