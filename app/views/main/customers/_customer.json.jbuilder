json.extract! customer, :id, :name, :matriculation, :status, :password, :created_at, :updated_at
json.url customer_url(customer, format: :json)
