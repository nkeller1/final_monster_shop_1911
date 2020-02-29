require 'rails_helper'

RSpec.describe 'On Merchant Discount Edit page' do
  it "can navigate to the discount edit page" do
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
      click_link "Edit Discount"
    end

    expect(current_path).to eq("/merchant/discounts/#{discount.id}/edit")

    expect(find_field('Name').value).to eq "Pencil Discount"
    expect(find_field('Quantity Required').value).to eq '10'
    expect(find_field('Percentage').value).to eq "10"

    expect(page).not_to have_content(discount_1.name)
  end

  it "can edit the discount information and submit" do

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

     discount = Discount.create(
        name: 'Pencil Discount',
        quantity_required: 10,
        percentage: 10,
        merchant: bike_shop
      )

    visit "/merchant/discounts/#{discount.id}/edit"

    fill_in 'Name', with: "Pencil Discount2"
    fill_in 'Quantity Required', with: 20
    fill_in 'Percentage', with: 20

    click_button "Update Discount"
  end
end
