class RemoveBillingDefaultFromAddress < ActiveRecord::Migration[5.0]
  def change
    remove_column :addresses, :billing_default, :boolean
    remove_column :addresses, :shipping_default, :boolean
  end
end
