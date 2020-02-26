require "rails_helper"
RSpec.describe "as an admin" do
  it "on an admin users show page" do
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

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

    visit "/admin/users/#{merchant_user_2.id}"

    expect(page).to have_content(merchant_user_2.name)
    expect(page).to have_content(merchant_user_2.address)
    expect(page).to have_content(merchant_user_2.city)
    expect(page).to have_content(merchant_user_2.state)
    expect(page).to have_content(merchant_user_2.zip)
    expect(page).to have_content(merchant_user_2.email)
    expect(page).to have_link("Update Password")
    expect(page).to have_content("User Has No Orders")
  end
end
