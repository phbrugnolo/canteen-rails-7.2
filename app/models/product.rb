class Product < ApplicationRecord
  include Activatable

  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 50 }
  validates :price, presence: true, numericality: true

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "description", "id", "name", "price", "status", "updated_at" ]
  end
end
