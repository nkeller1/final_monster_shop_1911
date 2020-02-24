require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  it "can see all orders in the system" do

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

    order_1 = default_user.orders.create!(
      name: 'Meg',
      address: '123 Stang Ave',
      city: 'Hershey',
      state: 'PA',
      zip: 17033,
      status: 0)

    order_2 = default_user.orders.create!(
      name: 'Jon',
      address: '123 Jon Ave',
      city: 'Cool',
      state: 'CO',
      zip: 32525,
      status: 1)

    order_3 = default_user.orders.create!(
      name: 'Jacob',
      address: '123 Jacob Street',
      city: 'Places',
      state: 'WY',
      zip: 23652,
      status: 2)

    order_4 = default_user.orders.create!(
      name: 'Jingle',
      address: '123 Jingle Way',
      city: 'To',
      state: 'FL',
      zip: 23553,
      status: 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

    visit '/admin'

    within "#orders-#{order_1.id}" do
      expect(page).to have_content(order_1.id)
      expect(page).to have_content(order_1.user.name)
      expect(page).to have_content(order_1.created_at.strftime("%_m/%e/%C"))
      expect(page).to have_content(order_1.status)
    end

    within "#orders-#{order_2.id}" do
      expect(page).to have_content(order_2.id)
      expect(page).to have_content(order_2.user.name)
      expect(page).to have_content(order_2.created_at.strftime("%_m/%e/%C"))
      expect(page).to have_content(order_2.status)
    end

    within "#orders-#{order_3.id}" do
      expect(page).to have_content(order_3.id)
      expect(page).to have_content(order_3.user.name)
      expect(page).to have_content(order_3.created_at.strftime("%_m/%e/%C"))
      expect(page).to have_content(order_3.status)
    end

    within "#orders-#{order_4.id}" do
      expect(page).to have_content(order_4.id)
      expect(page).to have_content(order_4.user.name)
      expect(page).to have_content(order_4.created_at.strftime("%_m/%e/%C"))
      expect(page).to have_content(order_4.status)
    end
  end

  it "I see any packaged orders ready to ship" do
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

    order_1 = default_user.orders.create!(
      name: 'Meg',
      address: '123 Stang Ave',
      city: 'Hershey',
      state: 'PA',
      zip: 17033,
      status: 0)

    order_2 = default_user.orders.create!(
      name: 'Jon',
      address: '123 Jon Ave',
      city: 'Cool',
      state: 'CO',
      zip: 32525,
      status: 0)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

    visit '/admin'

    within "#orders-#{order_2.id}" do
      expect(page).to have_content("Packaged")
      click_on "Ship"
      expect(page).to have_content("Shipped")
    end
  end
end
