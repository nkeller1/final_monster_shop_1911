require 'rails_helper'

RSpec.describe "on a merchant dashboard show page" do
  context "as a merchant employee" do
    before(:each) do
      @admin_user = User.create(
          name: "Dave H",
          address: "321 Notmain Rd.",
          city: "Broomfield",
          state: "CO",
          zip: "80020",
          email: "davidh@example.com",
          password: "supersecure1",
          role: 2)

      @bike_shop = Merchant.create(
        name: "Brian's Bike Shop",
        address: '123 Bike Rd.',
        city: 'Richmond',
        state: 'VA',
        zip: 11234)

      @dog_shop = Merchant.create(
        name: "Brian's Dog Shop",
        address: '125 Doggo St.',
        city: 'Denver',
        state: 'CO',
        zip: 80210)

      @merchant_user = User.create(
        name: "Maria R",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariaaa@example.com",
        password: "supersecure1",
        role: 1,
        merchant: @bike_shop)

      @default_user_1 = User.create({
          name: "Paul D",
          address: "123 Main St.",
          city: "Broomfield",
          state: "CO",
          zip: "80020",
          email: "mariar@example.com",
          password: "supersecure1",
          role: 0
          })

      @default_user_2 = User.create({
        name: "Default User",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "default@example.com",
        password: "password",
        role: 0
        })

      @wheels = Item.create(
        name: "Gatorskins",
        description: "They'll never pop!",
        price: 100,
        image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
        inventory: 12,
        merchant: @bike_shop)

       @pencil = Item.create(
         name: "Yellow Pencil",
         description: "You can write on paper with it!",
         price: 2,
         image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
         inventory: 100,
         merchant: @bike_shop)

       @dog_food = Item.create(
          name: "Ol' Roy",
          description: "You can write on paper with it!",
          price: 45,
          image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
          inventory: 100,
          merchant: @dog_shop)

        @order_1 = Order.create(
          name: 'Meg',
          address: '123 Stang Ave',
          city: 'Hershey',
          state: 'PA',
          zip: 17033,
          user: @default_user_1,
          status: 1)

        @order_2 = Order.create(
          name: 'Jon',
          address: '123 Jon Ave',
          city: 'Cool',
          state: 'CO',
          zip: 32525,
          user: @default_user_2,
          status: 1)

        @order_3 = Order.create(
          name: 'Jacob',
          address: '123 Jon Ave',
          city: 'Cool',
          state: 'CO',
          zip: 32525,
          user: @default_user_3,
          status: 0)

        @order_4 = Order.create(
          name: 'Meg',
          address: '123 Stang Ave',
          city: 'Hershey',
          state: 'PA',
          zip: 17033,
          user: @default_user_1,
          status: 0)

        @item_order_1 = ItemOrder.create(
          item: @wheels,
          price: @wheels.price,
          quantity: 2,
          order: @order_1)

        @item_order_2 = ItemOrder.create(
          item: @pencil,
          price: @pencil.price,
          quantity: 1,
          order: @order_2)

        @item_order_3 = ItemOrder.create(
          item: @wheels,
          price: @wheels.price,
          quantity: 1,
          order: @order_2)

        @item_order_4 = ItemOrder.create(
          item: @dog_food,
          price: @dog_food.price,
          quantity: 1,
          order: @order_3)

        @item_order_5 = ItemOrder.create(
          item: @dog_food,
          price: @dog_food.price,
          quantity: 1,
          order: @order_4)
    end

    it "I can see the name and address of the merchant I work for" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)

      visit "/merchant"

      expect(page).to have_content(@bike_shop.name)
      expect(page).to have_content(@bike_shop.address)
      expect(page).to have_content(@bike_shop.city)
      expect(page).to have_content(@bike_shop.state)
      expect(page).to have_content(@bike_shop.zip)
    end

    it "I can see pending orders containing items I sell" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)

      visit "/merchant"

      within("#order-#{@order_1.id}") do
        expect(page).to have_content(@order_1.name)
        expect(page).to have_link(@order_1.id)
        expect(page).to have_content(@order_1.created_at.strftime("%_m/%e/%C"))
        expect(page).to have_content(@item_order_1.quantity)
        expect(page).to have_content(@order_1.grandtotal)
      end

      within("#order-#{@order_2.id}") do
        expect(page).to have_content(@order_2.name)
        expect(page).to have_content(@order_2.created_at.strftime("%_m/%e/%C"))
        expect(page).to have_content(@item_order_2.quantity)
        expect(page).to have_content(@order_2.grandtotal)
        expect(page).to have_link(@order_2.id)
        expect(page).to_not have_content(@order_3.name)
      end
    end

    it "I can click a link on my dashboard that takes me to view my items" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)

      visit "/merchant"
      click_link "My Items"
      expect(current_path).to eq("/merchant/items")
    end

    context "as an admin user" do
      it "I can see everything a merchant would see" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)

        visit "/merchants"
        click_link "#{@bike_shop.name}"
        expect(current_path).to eq("/admin/merchants/#{@bike_shop.id}")

        expect(page).to have_content(@bike_shop.name)
        expect(page).to have_content(@bike_shop.address)
        expect(page).to have_content(@bike_shop.city)
        expect(page).to have_content(@bike_shop.state)
        expect(page).to have_content(@bike_shop.zip)

        within("#order-#{@order_1.id}") do
          expect(page).to have_content(@order_1.name)
          expect(page).to have_link(@order_1.id)
          expect(page).to have_content(@order_1.created_at)
          expect(page).to have_content(@item_order_1.quantity)
          expect(page).to have_content(@order_1.grandtotal)
        end
      end
    end
  end
end
# User Story 37, Admin can see a merchant's dashboard
#
# As an admin user
# When I visit the merchant index page ("/merchants")
# And I click on a merchant's name,
# Then my URI route should be ("/admin/merchants/6")
# Then I see everything that merchant would see
