class CreateSales < ActiveRecord::Migration[7.2]
  def change
    create_table :sales do |t|
      t.json :cart
      t.decimal :total_price

      t.timestamps
    end
  end
end