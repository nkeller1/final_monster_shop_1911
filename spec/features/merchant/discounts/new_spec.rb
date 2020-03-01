require 'rails_helper'

RSpec.describe 'A merchant user can create a new discount' do
  it "can navigate to the discount new page" do
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

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

    visit '/merchant/discounts'

    click_on "Create New Discount"

    expect(current_path).to eq("/merchant/discounts/new")

    expect(find_field('Name'))
    expect(find_field('Quantity required'))
    expect(find_field('Percentage'))
  end

  it "can create a new discount" do
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

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

    visit '/merchant/discounts/new'

    fill_in :name, with: "Frog Discount"
    fill_in :quantity_required, with: 20
    fill_in :percentage, with: 10

    find('#item_item_id').find('option', text: 'Yellow Pencil').select_option

    click_on "Create Discount"

    expect(current_path).to eq("/merchant/discounts")
    expect(page).to have_content("Frog Discount Created Successfully")

    expect(page).to have_content("Frog Discount")
    expect(page).to have_content(20)
    expect(page).to have_content(10)
  end

  it "show an error if a field is missing information" do
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

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

    visit '/merchant/discounts/new'

    fill_in :name, with: ""
    fill_in :quantity_required, with: 20
    fill_in :percentage, with: 10
    find('#dropdown-list').click
    find('#dropdown-list option', :text => 'Yellow Pencil').click


    click_on "Create Discount"

    expect(page).to have_content("Name can't be blank")
  end
end
