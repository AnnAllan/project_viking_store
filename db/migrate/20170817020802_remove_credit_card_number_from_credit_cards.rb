class RemoveCreditCardNumberFromCreditCards < ActiveRecord::Migration[5.0]
  def change
    remove_column :credit_cards, :card_number
  end
end
