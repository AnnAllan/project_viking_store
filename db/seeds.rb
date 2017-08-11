require 'faker'
puts "Destroying old records..."
Faker::UniqueGenerator.clear
Address.destroy_all
User.destroy_all
Category.destroy_all
CreditCard.destroy_all
Order.destroy_all
OrderContent.destroy_all
Product.destroy_all
puts "Old records destroyed"

puts "Creating 20 Users..."
20.times do
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.unique.email,
              telephone: Faker::PhoneNumber.phone_number)
end
puts "20 Users created."

puts "Creating 60 Addresses..."
def generate_address(billing, shipping, user_id)
  Address.create(street_address: Faker::Address.street_address,
                 zip_code: Faker::Address.zip,
                 city: Faker::Address.city,
                 state_abbr: Faker::Address.state_abbr,
                 billing_default: billing,
                 shipping_default: shipping,
                 user_id: user_id)
end
20.times do |i|
  generate_address(true, false, i + 1)
  generate_address(false, true, i + 1)
  generate_address(false, false, i + 1)
end
puts "60 Addresses created."

puts "Creating 8 Categories..."
8.times do
  Category.create(name: Faker::Commerce.unique.department,
                  description: Faker::Commerce.material)
end
puts "8 Categories created."

puts "Creating 40 Credit Cards..."
def generate_credit_cards(default, user_id)
  CreditCard.create(nickname: Faker::Business.credit_card_type,
                    card_number: Faker::Number.unique.number(4),
                    exp_month: rand(12) + 1,
                    exp_year: Time.now.year + rand(5),
                    ccv: Faker::Number.number(3),
                    brand: ["Visa", "MasterCard", "Discover"].sample,
                    user_id: user_id,
                    default_card: default)
end
20.times do |i|
  generate_credit_cards(true, i + 1)
  generate_credit_cards(false, i + 1)
end
puts "40 Credit Cards created."

puts "Creating 60 Products..."
60.times do
  Product.create(name: Faker::Commerce.product_name,
                sku: Faker::Code.ean,
                description: Faker::Commerce.material,
                price: Faker::Commerce.price,
                category_id: rand(1..8) + 1)
end
puts "60 Products created."

puts "Creating 10 Orders..."
10.times do |i|
  Order.create(checkout_date: Faker::Date.between(2.days.ago, Date.today),
                user_id: i + 1,
                shipping_id: 3 * i + 2,
                billing_id: 3 * i + 1,
                credit_card_id: i + i + 1)
end
puts "10 Orders created."

puts "Creating 10 Order Contents..."
10.times do |i|
  OrderContent.create(order_id: i + 1,
                      product_id: rand(59) + 1,
                      quantity: rand(3) + 1)
end
puts "10 Order Contents Created."
