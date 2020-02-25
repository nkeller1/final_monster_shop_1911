require 'rails_helper'

RSpec.describe 'Merchant delete item' do
  it 'can delete items that have not been ordered' do
    bike_shop = Merchant.create(
      name: "Brian's Bike Shop",
      address: '123 Bike Rd.',
      city: 'Richmond',
      state: 'VA',
      zip: 11234)

    default_user_1 = User.create({
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
       active?: true,
       merchant: bike_shop)

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
         user: default_user_1,
         status: 1)

       item_order_1 = ItemOrder.create(
         item: wheels,
         price: wheels.price,
         quantity: 2,
         order: order_1)

       item_order_1 = ItemOrder.create(
         item: pencil,
         price: pencil.price,
         quantity: 2,
         order: order_1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

    visit "/merchant/items"

    within("#item-#{wheels.id}") do
      expect(page).to_not have_link("Delete")
    end

    within("#item-#{pencil.id}") do
      expect(page).to_not have_link("Delete")
    end

    within("#item-#{dog_food.id}") do
      click_link("Delete")
    end

    expect(current_path).to eq("/merchant/items")

    expect(page).to have_content("This item is now deleted.")
    expect(page).to_not have_content(dog_food.name)
  end
end
