require 'rails_helper'

RSpec.describe 'On Merchant Discount index page' do
  it "has a link from the dashboard to take me to discount index page" do
    bike_shop = Merchant.create(
      name: "Brian's Bike Shop",
      address: '123 Bike Rd.',
      city: 'Richmond',
      state: 'VA',
      zip: 11234)

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

    wheels = Item.create(
      name: "Gatorskins",
      description: "They'll never pop!",
      price: 100,
      image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
      inventory: 12,
      merchant: bike_shop)

     pencil = Item.create(
       name: "Yellow Pencil",
       description: "You can write on paper with it!",
       price: 10,
       image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
       inventory: 100,
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

      item_order_2 = ItemOrder.create(
        item: pencil,
        price: pencil.price,
        quantity: 5,
        order: order_1)

      discount = Discount.create(
        name: 'Pencil Discount',
        quantity_required: 10,
        percentage: 10,
        merchant: bike_shop
      )

      discount_1 = Discount.create(
        name: 'Wheels Discount',
        quantity_required: 5,
        percentage: 5,
        merchant: bike_shop
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

      visit '/merchant'

      click_on 'Bulk Discounts'

      expect(current_path).to eq('/merchant/discounts')
  end

it "shows all of the information for each discount in the system" do
  bike_shop = Merchant.create(
    name: "Brian's Bike Shop",
    address: '123 Bike Rd.',
    city: 'Richmond',
    state: 'VA',
    zip: 11234)

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

  wheels = Item.create(
    name: "Gatorskins",
    description: "They'll never pop!",
    price: 100,
    image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
    inventory: 12,
    merchant: bike_shop)

   pencil = Item.create(
     name: "Yellow Pencil",
     description: "You can write on paper with it!",
     price: 10,
     image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
     inventory: 100,
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

    item_order_2 = ItemOrder.create(
      item: pencil,
      price: pencil.price,
      quantity: 5,
      order: order_1)

    discount = Discount.create(
      name: 'Pencil Discount',
      quantity_required: 10,
      percentage: 10,
      merchant: bike_shop
    )

    discount_1 = Discount.create(
      name: 'Wheels Discount',
      quantity_required: 5,
      percentage: 5,
      merchant: bike_shop
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

    visit '/merchant/discounts'
    
      within "#discount-#{discount.id}" do
        expect(page).to have_content(discount.name)
        expect(page).to have_content("Quantity Required: 10")
        expect(page).to have_content("Percentage Off: 10%")
      end

      within "#discount-#{discount_1.id}" do
        expect(page).to have_content(discount_1.name)
        expect(page).to have_content("Quantity Required: 5")
        expect(page).to have_content("Percentage Off: 5%")
      end
  end
end
