class AddTelephoneToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :telephone, :integer
  end
end
