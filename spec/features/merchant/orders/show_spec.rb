require 'rails_helper'

RSpec.describe "Order Show Page" do
  it "can see the order information" do


    dog_shop = Merchant.create(
      name: "Brian's Dog Shop",
      address: '125 Doggo St.',
      city: 'Denver',
      state: 'CO',
      zip: 80210)

    bike_shop = Merchant.create(
      name: "Brian's Bike Shop",
      address: '123 Bike Rd.',
      city: 'Richmond',
      state: 'VA',
      zip: 11234)

    default_user = User.create({
      name: "Paul D",
      address: "123 Main St.",
      city: "Broomfield",
      state: "CO",
      zip: "80020",
      email: "mariar@example.com",
      password: "supersecure1",
      role: 0
      })

    merchant_user = User.create(
      name: "Maria R",
      address: "321 Notmain Rd.",
      city: "Broomfield",
      state: "CO",
      zip: "80020",
      email: "mariaaa@example.com",
      password: "supersecure1",
      role: 1,
      merchant: bike_shop)

    pencil = Item.create(
      name: "Yellow Pencil",
      description: "You can write on paper with it!",
      price: 2,
      image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
      inventory: 100,
      active?: true,
      merchant: bike_shop)

    dog_food = Item.create(
       name: "Ol' Roy",
       description: "You can write on paper with it!",
       price: 45,
       image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
       inventory: 100,
       merchant: dog_shop)

    wheels = Item.create(
      name: "Gatorskins",
      description: "They'll never pop!",
      price: 100,
      image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
      inventory: 12,
      active?: false,
      merchant: bike_shop)

    order_1 = Order.create(
      name: 'Meg',
      address: '123 Stang Ave',
      city: 'Hershey',
      state: 'PA',
      zip: 17033,
      user: default_user,
      status: 1)

    order_2 = Order.create(
      name: 'Jon',
      address: '123 Jon Ave',
      city: 'Cool',
      state: 'CO',
      zip: 32525,
      user: default_user,
      status: 1)

    item_order_1 = ItemOrder.create(
      item: wheels,
      price: wheels.price,
      quantity: 2,
      order: order_1)

    item_order_2 = ItemOrder.create(
      item: dog_food,
      price: dog_food.price,
      quantity: 1,
      order: order_1)

    item_order_3 = ItemOrder.create(
      item: wheels,
      price: wheels.price,
      quantity: 1,
      order: order_2)

    item_order_4 = ItemOrder.create(
      item: pencil,
      price: pencil.price,
      quantity: 1,
      order: order_2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

    visit '/merchant'

    within("#order-#{order_1.id}") do
      click_link "#{order_1.id}"
    end

    expect(current_path).to eq("/merchant/orders/#{order_1.id}")

    expect(page).to have_content(order_1.name)
    expect(page).to have_content(order_1.address)
    expect(page).to have_content(order_1.city)
    expect(page).to have_content(order_1.state)
    expect(page).to have_content(order_1.zip)

    expect(page).to have_link(wheels.name)
    expect(page).to have_content("Quantity: 2")
    expect(page).to have_css("img[src*='#{wheels.image}']")
    expect(page).to have_content(wheels.price)

    expect(page).not_to have_content(dog_food.name)
    expect(page).not_to have_css("img[src*='#{dog_food.image}']")
  end

  it "can see the order information" do


    dog_shop = Merchant.create(
      name: "Brian's Dog Shop",
      address: '125 Doggo St.',
      city: 'Denver',
      state: 'CO',
      zip: 80210)

    bike_shop = Merchant.create(
      name: "Brian's Bike Shop",
      address: '123 Bike Rd.',
      city: 'Richmond',
      state: 'VA',
      zip: 11234)

    default_user = User.create({
      name: "Paul D",
      address: "123 Main St.",
      city: "Broomfield",
      state: "CO",
      zip: "80020",
      email: "mariar@example.com",
      password: "supersecure1",
      role: 0
      })

    merchant_user = User.create(
      name: "Maria R",
      address: "321 Notmain Rd.",
      city: "Broomfield",
      state: "CO",
      zip: "80020",
      email: "mariaaa@example.com",
      password: "supersecure1",
      role: 1,
      merchant: bike_shop)

    pencil = Item.create(
      name: "Yellow Pencil",
      description: "You can write on paper with it!",
      price: 2,
      image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
      inventory: 100,
      active?: true,
      merchant: bike_shop)

    dog_food = Item.create(
       name: "Ol' Roy",
       description: "You can write on paper with it!",
       price: 45,
       image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
       inventory: 100,
       merchant: dog_shop)

    wheels = Item.create(
      name: "Gatorskins",
      description: "They'll never pop!",
      price: 100,
      image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
      inventory: 12,
      active?: false,
      merchant: bike_shop)

    order_1 = Order.create(
      name: 'Meg',
      address: '123 Stang Ave',
      city: 'Hershey',
      state: 'PA',
      zip: 17033,
      user: default_user,
      status: 1)

    order_2 = Order.create(
      name: 'Jon',
      address: '123 Jon Ave',
      city: 'Cool',
      state: 'CO',
      zip: 32525,
      user: default_user,
      status: 1)

    item_order_1 = ItemOrder.create(
      item: wheels,
      price: wheels.price,
      quantity: 2,
      order: order_1)

    item_order_2 = ItemOrder.create(
      item: dog_food,
      price: dog_food.price,
      quantity: 1,
      order: order_1)

    item_order_3 = ItemOrder.create(
      item: wheels,
      price: wheels.price,
      quantity: 1,
      order: order_2)

    item_order_4 = ItemOrder.create(
      item: pencil,
      price: pencil.price,
      quantity: 1,
      order: order_2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

    visit "/merchant/orders/#{order_1.id}"

    within "#item-order-#{item_order_1.id}" do
      click_button "Fulfill"
    end

    expect(current_path).to eq("/merchant/orders/#{order_1.id}")

    within "#item-order-#{item_order_1.id}" do
      expect(page).not_to have_button("Fulfill")
      expect(page).to have_content("Fulfilled")
    end

    expect(page).to have_content("Item on Order Fulfilled")
  end
end
