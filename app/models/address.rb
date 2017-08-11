class Address < ApplicationRecord
  belongs_to :user

  has_many :orders_billed_here,
            class_name: "Order",
            foreign_key: :billing_id

  has_many :orders_shipped_here,
            class_name: "Order",
            foreign_key: :shipping_id

  validates :city, :state_abbr, :zip_code, :street_address,
                      presence: true

  def full_address
    "#{street_address}, #{city.name}, #{state.name} #{zip_code}"
  end
end
