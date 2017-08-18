class AddCardNumberToCreditCard < ActiveRecord::Migration[5.0]
  def change
    add_column :credit_cards, :card_number, :string
  end
end
