require 'rails_helper'

RSpec.describe "As a merchant user" do
    it "I can delete a discount " do

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

      discount_1 = Discount.create(
         name: 'Pencil Discount',
         quantity_required: 10,
         percentage: 10,
         merchant: bike_shop
       )

     discount_2 = Discount.create(
       name: 'Wheels Discount',
       quantity_required: 5,
       percentage: 5,
       merchant: bike_shop
     )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

      visit "merchant/discounts"

      within "#discount-#{discount_1.id}" do
        click_on "Delete Discount"
      end

      expect(current_path).to eq('/merchant/discounts')
      expect(page).to_not have_content('Pencil Discount')
      expect(page).to have_content('Wheels Discount')
    end
  end
