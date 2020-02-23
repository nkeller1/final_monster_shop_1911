require 'rails_helper'

RSpec.describe "on a merchant dashboard show page" do
  context "as a merchant employee" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 11234)
      @merchant_user = User.create({
        name: "Maria R",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariaaa@example.com",
        password: "supersecure1",
        role: 1,
        merchant: @bike_shop
        })
        @order_1 = Order.new
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)
    end
    it "I can see the name and address of the merchant I work for" do
      visit "/merchant"
      expect(page).to have_content(@bike_shop.name)
      expect(page).to have_content(@bike_shop.address)
      expect(page).to have_content(@bike_shop.city)
      expect(page).to have_content(@bike_shop.state)
      expect(page).to have_content(@bike_shop.zip)
    end

    # it "I can see pending orders containing items I sell" do
    #   visit "/merchant"
    #
    # end
  end
end
# User Story 35, Merchant Dashboard displays Orders
#
# As a merchant employee
# When I visit my merchant dashboard ("/merchant")
# If any users have pending orders containing items I sell
# Then I see a list of these orders.
# Each order listed includes the following information:
# - the ID of the order, which is a link to the order show page ("/merchant/orders/15")
# - the date the order was made
# - the total quantity of my items in the order
# - the total value of my items for that order
