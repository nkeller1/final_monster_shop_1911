require 'rails_helper'

RSpec.describe "As a registered user" do
  it "I can see pending status after creating order" do

    bike_shop = Merchant.create(
                name: "Meg's Bike Shop",
                address: '123 Bike Rd.',
                city: 'Denver',
                state: 'CO',
                zip: 80203)

    dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)

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

    default_user_2 = User.create!({
                name: "Maria",
                address: "125 Main St.",
                city: "Broomfield",
                state: "CO",
                zip: "80010",
                email: "MR@example.com",
                password: "supersecure1",
                role: 0
                })

    order_2 = default_user_1.orders.create!(
                name: 'Maria',
                address: '123 Main st',
                city: 'Hershey',
                state: 'PA',
                zip: 17033,
                status: 0)

    order_2.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 5)
    order_2.item_orders.create!(item: dog_bone, price: dog_bone.price, quantity: 5)

    order_1 = default_user_1.orders.create!(
                name: 'Meg',
                address: '123 Stang Ave',
                city: 'Hershey',
                state: 'PA',
                zip: 17033,
                status: 0)

    tire = bike_shop.items.create(
              name: "Gatorskins",
              description: "They'll never pop!",
              price: 100,
              image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
              inventory: 12)

    paper = bike_shop.items.create(
              name: "Lined Paper",
              description: "Great for writing on!",
              price: 20,
              image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png",
              inventory: 3)

    item_order_1 = order_1.item_orders.create!(
                item: tire,
                price: tire.price,
                quantity: 2)

    item_order_2 = order_1.item_orders.create!(
                item: paper,
                price: paper.price,
                quantity: 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user_1)

    visit '/profile/orders'

    click_link("#{order_1.id}")

    expect(current_path).to eq("/profile/orders/#{order_1.id}")
    expect(page).to have_content("Order ID: #{order_1.id}")
    expect(page).to have_content("Order Placed:#{order_1.created_at.strftime("%_m/%e/%C")}")
    expect(page).to have_content("Order Updated:#{order_1.updated_at.strftime("%_m/%e/%C")}")
    expect(page).to have_content("Order Status: Pending")


    within "#item-#{tire.id}" do
      expect(page).to have_content(tire.name)
      expect(page).to have_content(tire.description)
      expect(page).to have_css("img[src*='#{tire.image}']")
    end

    within "#item_order-#{item_order_1.id}" do
      expect(page).to have_content(2)
      expect(page).to have_content(tire.price)
      expect(page).to have_content(200)
    end
    within "#item-#{paper.id}" do
      expect(page).to have_content(paper.name)
      expect(page).to have_content(paper.description)
      expect(page).to have_css("img[src*='#{paper.image}']")
    end

    within "#item_order-#{item_order_2.id}" do
      expect(page).to have_content(3)
      expect(page).to have_content(paper.price)
      expect(page).to have_content(60)
    end
    expect(page).to have_content("Total Items in Order: 5")
    expect(page).to have_content("Grand Total: $260")
  end
end
