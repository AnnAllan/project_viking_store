class Category < ApplicationRecord
  has_many :products

  validates :name,
            presence: true,
            uniqueness: true,
            allow_blank: false,
            allow_nil: false
end
