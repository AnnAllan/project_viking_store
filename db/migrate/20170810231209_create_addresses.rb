class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string  "street_address",    null: false
      t.string  "zip_code",          null: false
      t.string  "city",              null: false
      t.string  "state_abbr",        null: false
      t.boolean "billing_default"
      t.boolean "shipping_default"
      t.integer "user_id",           null: false
      t.timestamps
    end
  end
end
