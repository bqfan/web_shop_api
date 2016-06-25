class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, default: ""
      t.decimal :price, default: 0.0
      t.integer :stock, default: 0
      t.boolean :published, default: false
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :products, :name
    add_index :products, :price
    add_index :products, :user_id
  end
end
