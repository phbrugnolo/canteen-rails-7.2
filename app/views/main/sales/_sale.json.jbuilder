json.extract! sale, :id, :cart, :total_price, :created_at, :updated_at
json.url sale_url(sale, format: :json)
