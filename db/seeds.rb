# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Merchant.destroy_all
Item.destroy_all
User.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

default_user = User.create({
  name: "Default User",
  address: "123 Main St.",
  city: "Broomfield",
  state: "CO",
  zip: "80020",
  email: "default@example.com",
  password: "password",
  role: 0
  })

merchant_user = User.create({
  name: "Merchant User",
  address: "123 Main St.",
  city: "Broomfield",
  state: "CO",
  zip: "80020",
  email: "merchant@example.com",
  password: "password",
  role: 1,
  merchant: bike_shop
  })

merchant_user_2 = User.create({
  name: "Merchant User 2",
  address: "123 Main St.",
  city: "Broomfield",
  state: "CO",
  zip: "80020",
  email: "merchant2@example.com",
  password: "password",
  role: 1,
  merchant: dog_shop
  })

admin_user = User.create({
  name: "Admin User",
  address: "123 Main St.",
  city: "Broomfield",
  state: "CO",
  zip: "80020",
  email: "admin@example.com",
  password: "password",
  role: 2
  })


  #bike_shop items
  tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
  paper = bike_shop.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
  pencil = bike_shop.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
  bike = bike_shop.items.create(name: "Bike", description: "Great for riding on!", price: 2000, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 2)
  pump = bike_shop.items.create(name: "Pump", description: "for filling flat tires", price: 25, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 15)

  #dog_shop items
  pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
  dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
  leash = dog_shop.items.create(name: "Dog Leash", description: "They'll Probably Hate it!", price: 9, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 36)
  dog_food = dog_shop.items.create(name: "Dog Food", description: "Food is good", price: 42, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 43)
  food_bowl = dog_shop.items.create(name: "Food Bowl", description: "where doggos eat", price: 31, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 52)


  order_1 = default_user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
  order_2 = default_user.orders.create!(name: 'Jon', address: '123 Jon Ave', city: 'Cool', state: 'CO', zip: 32525)
  order_3 = default_user.orders.create!(name: 'Jacob', address: '123 Jacob Street', city: 'Places', state: 'WY', zip: 23652)
  order_4 = default_user.orders.create!(name: 'Jingle', address: '123 Jingle Way', city: 'To', state: 'FL', zip: 23553)
  order_5 = default_user.orders.create!(name: 'Hymer', address: '123 Hymer Schmitt', city: 'Live', state: 'CA', zip: 45332)

  order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)
  order_1.item_orders.create!(item: paper, price: paper.price, quantity: 3)
  order_2.item_orders.create!(item: pencil, price: pencil.price, quantity: 1)
  order_3.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 3)
  order_3.item_orders.create!(item: dog_bone, price: dog_bone.price, quantity: 5)
  order_4.item_orders.create!(item: dog_food, price: dog_food.price, quantity: 7)
  order_5.item_orders.create!(item: bike, price: bike.price, quantity: 1)
