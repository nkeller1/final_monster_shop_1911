require 'rails_helper'

RSpec.describe "As a registered user" do
  it "I can see pending status after creating order" do
    default_user_1 = User.create!({
      name: "Paul D",
      address: "123 Main St.",
      city: "Broomfield",
      state: "CO",
      zip: "80020",
      email: "mariar@example.com",
      password: "supersecure1",
      role: 0
      })

    visit "/login"
    fill_in :email, with: default_user_1[:email]
    fill_in :password, with: "supersecure1"
    click_button "Sign In"

    visit '/profile/orders'

    expect(page).not_to have_content("Pending")

    order_1 = default_user_1.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 0)

    visit '/profile/orders'

    expect(page).to have_content("Pending")
  end

  it "I can see every order I've made and relevant information" do
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    default_user_1 = User.create!({
      name: "Paul D",
      address: "123 Main St.",
      city: "Broomfield",
      state: "CO",
      zip: "80020",
      email: "mariar@example.com",
      password: "supersecure1",
      role: 0
      })

    visit "/login"
    fill_in :email, with: default_user_1[:email]
    fill_in :password, with: "supersecure1"
    click_button "Sign In"

    order_1 = default_user_1.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 0)

    order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)

    visit '/profile/orders'
    expect(page).to have_link("#{order_1.id}")
    expect(page).to have_content(order_1.created_at.strftime("%_m/%e/%C"))
    expect(page).to have_content(order_1.updated_at.strftime("%_m/%e/%C"))
    expect(page).to have_content("Total Quantity")
    expect(page).to have_content("Grand Total")

    within "#total-quantity-#{order_1.id}" do
      expect(page).to have_content("2")
    end

    within "#grand-total-#{order_1.id}" do
      expect(page).to have_content("$200.0")
    end
  end
end
