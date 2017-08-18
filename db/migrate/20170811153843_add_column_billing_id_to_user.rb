class AddColumnBillingIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :billing_id, :integer
    add_column :users, :shipping_id, :integer
  end
end
