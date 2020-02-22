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
end
