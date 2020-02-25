require 'rails_helper'

RSpec.describe 'Merchant Items Index page' do
  it 'can show all items the merchant has and can activate/deactive items' do
    bike_shop = Merchant.create(
      name: "Brian's Bike Shop",
      address: '123 Bike Rd.',
      city: 'Richmond',
      state: 'VA',
      zip: 11234)

    dog_shop = Merchant.create(
      name: "Brian's Dog Shop",
      address: '125 Doggo St.',
      city: 'Denver',
      state: 'CO',
      zip: 80210)

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
       merchant: dog_shop)

     wheels = Item.create(
       name: "Gatorskins",
       description: "They'll never pop!",
       price: 100,
       image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
       inventory: 12,
       active?: false,
       merchant: bike_shop)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

    visit '/merchant/items'

    within("item-#{pencil.id}") do
      expect(page).to have_content(pencil.name)
      expect(page).to have_content(pencil.description)
      expect(page).to have_content(pencil.price)
      expect(page).to have_content(pencil.inventory)
      expect(page).to have_content("Status: Active")
      click_button("Deactivate")
    end

    within("item-#{pencil.id}") do
      expect(page).to have_content("Status: Inactive")
    end

    expect(current_path).to eq('/merchant/items')
    expect(page).to have_content("#{pencil.name} has been Deactivated")

    within("item-#{tire.id}") do
      expect(page).to have_content(tire.name)
      expect(page).to have_content(tire.description)
      expect(page).to have_content(tire.price)
      expect(page).to have_content(tire.inventory)
      expect(page).to have_content("Status: Inactive")
      click_button("Activate")
    end

    within("item-#{tire.id}") do
      expect(page).to have_content("Status: Active")
    end

    expect(current_path).to eq('/merchant/items')
    expect(page).to have_content("#{tire.name} has been Activated")
    expect(page).not_to have_content(dog_food.name)
  end
end
