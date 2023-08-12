class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_id
      t.string :price_id
      t.string :name
      t.text :description
      t.string :currency
      t.integer :unit_amount
      t.text :payment_link
      t.timestamps
    end
  end
end
