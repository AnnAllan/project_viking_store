class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string   "name",                                null: false
      t.string   "sku",                                 null: false
      t.text     "description"
      t.decimal  "price",       precision: 8, scale: 2, null: false
      t.integer  "category_id",                         null: false
      t.timestamps

    end
    add_index :products, :sku
  end
end
