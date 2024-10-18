class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :matriculation
      t.string :status
      t.string :image
      t.string :password

      t.timestamps
    end
  end
end
