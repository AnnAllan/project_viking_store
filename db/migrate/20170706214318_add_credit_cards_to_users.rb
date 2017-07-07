class AddCreditCardsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :credit_card_id, :integer
  end
end
