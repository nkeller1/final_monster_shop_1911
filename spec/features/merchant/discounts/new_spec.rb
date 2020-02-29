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

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

    visit '/merchant/discounts'

    click_on "Create New Discount"

    expect(current_path).to eq("/merchant/discounts/new")

    expect(find_field('Name'))
    expect(find_field('Quantity required'))
    expect(find_field('Percentage'))
  end
end
