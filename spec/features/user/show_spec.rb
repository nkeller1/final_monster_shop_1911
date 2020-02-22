require 'rails_helper'

RSpec.describe "Registered User Profile Page" do
  before :each do
    @default_user_1 = User.create({
      name: "Paul D",
      address: "123 Main St.",
      city: "Broomfield",
      state: "CO",
      zip: "80020",
      email: "pauld@example.com",
      password: "supersecure1",
      role: 0
      })

    @default_user_2 = User.create({
      name: "Daniel D",
      address: "1703 11th Ave",
      city: "Greeley",
      state: "CO",
      zip: "80634",
      email: "danield@example.com",
      password: "supersecure1",
      role: 0
      })
  end

  it "As a registered user" do


      visit "/login"
      fill_in :email, with: @default_user_1[:email]
      fill_in :password, with: "supersecure1"
      click_button "Sign In"


      expect(page).to have_content(@default_user_1.name)
      expect(page).to have_content(@default_user_1.address)
      expect(page).to have_content(@default_user_1.city)
      expect(page).to have_content(@default_user_1.state)
      expect(page).to have_content(@default_user_1.zip)
      expect(page).to have_content(@default_user_1.email)
      expect(page).to have_link("Edit Profile")
  end

  it "Shows a link to 'My Orders' if I have any orders" do
    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    order_1 = Order.create!(name: "#{@default_user_2.name}",
                            address: "#{@default_user_2.address}",
                            city: "#{@default_user_2.city}",
                            state: "#{@default_user_2.state}",
                            zip: "#{@default_user_2.zip}",
                            user_id: "#{@default_user_2.id}")

    order_2 = Order.create!(name: "#{@default_user_2.name}",
                            address: "#{@default_user_2.address}",
                            city: "#{@default_user_2.city}",
                            state: "#{@default_user_2.state}",
                            zip: "#{@default_user_2.zip}",
                            user_id: "#{@default_user_2.id}")
                            
    item_order_1 = order_1.item_orders.create!(item: paper, price: paper.price, quantity: 2)
    item_order_2 = order_1.item_orders.create!(item: pencil, price: pencil.price, quantity: 2)

    visit "/login"
    fill_in :email, with: @default_user_2[:email]
    fill_in :password, with: "supersecure1"
    click_button "Sign In"

    click_on 'My Orders'

    expect(current_path).to eq('/profile/orders')
  end

  it "Does not show the 'My Orders' link if I have not placed any orders" do
    visit "/login"
    fill_in :email, with: @default_user_1[:email]
    fill_in :password, with: "supersecure1"
    click_button "Sign In"

    expect(page).not_to have_content("My Orders")
  end
end

# As a registered user
# When I visit my Profile page
# And I have orders placed in the system
# Then I see a link on my profile page called "My Orders"
# When I click this link my URI path is "/profile/orders"
