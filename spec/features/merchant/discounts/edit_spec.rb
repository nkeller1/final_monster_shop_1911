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

    discount_1 = Discount.create(
      name: 'Pencil Discount',
      quantity_required: 10,
      percentage: 10,
      merchant: bike_shop,
      item: pencil
    )

    discount_2 = Discount.create(
      name: 'Wheels Discount',
      quantity_required: 5,
      percentage: 5,
      merchant: bike_shop,
      item: wheels
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

    visit '/merchant/discounts'

    within "#discount-#{discount_1.id}" do
      click_on "Edit Discount"
    end

    expect(current_path).to eq("/merchant/discounts/#{discount_1.id}/edit")

    expect(find_field('Name').value).to eq "Pencil Discount"
    expect(find_field('Quantity required').value).to eq '10'
    expect(find_field('Percentage').value).to eq "10"

    expect(page).not_to have_content(discount_2.name)
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

     pencil = Item.create(
       name: "Yellow Pencil",
       description: "You can write on paper with it!",
       price: 10,
       image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
       inventory: 100,
       merchant: bike_shop)

     discount_1 = Discount.create(
        name: 'Pencil Discount',
        quantity_required: 10,
        percentage: 10,
        merchant: bike_shop,
        item: pencil
      )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

    visit "/merchant/discounts/#{discount_1.id}/edit"

    fill_in :name, with: "Horray"
    fill_in :quantity_required, with: 20
    fill_in :percentage, with: 20

    click_button "Update Discount"

    expect(current_path).to eq("/merchant/discounts")

    expect(page).to have_content("Horray Updated Successfully")

    within "#discount-#{discount_1.id}" do
      expect(page).to have_content("Horray")
      expect(page).to have_content(20)
      expect(page).not_to have_content("Pencil Discount")
    end
  end

  it "gives an error message if any field is left blank" do

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

     pencil = Item.create(
       name: "Yellow Pencil",
       description: "You can write on paper with it!",
       price: 10,
       image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
       inventory: 100,
       merchant: bike_shop)

     discount_1 = Discount.create(
        name: 'Pencil Discount',
        quantity_required: 10,
        percentage: 10,
        merchant: bike_shop,
        item: pencil
      )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

    visit "/merchant/discounts/#{discount_1.id}/edit"

    fill_in :name, with: ""
    fill_in :quantity_required, with: ""
    fill_in :percentage, with: 20

    click_button "Update Discount"

    expect(current_path).to eq("/merchant/discounts/#{discount_1.id}/edit")

    expect(page).to have_content("Name can't be blank, Quantity required can't be blank, and Quantity required is not a number")
  end
end
