# User Story 52, Admin Merchant Index Page
#
# As an admin user
# When I visit the merchant's index page at "/admin/merchants"
# I see all merchants in the system
# Next to each merchant's name I see their city and state
# The merchant's name is a link to their Merchant Dashboard at routes such as "/admin/merchants/5"
# I see a "disable" button next to any merchants who are not yet disabled
# I see an "enable" button next to any merchants whose accounts are disabled
require "rails_helper"

RSpec.describe "as an admin user" do
  describe "on an admin merchant's index page" do
    it "can enable/disable merchants" do
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
    bike_shop = Merchant.create(name: "Meg's Bike Shop",
       address: '123 Bike Rd.',
       city: 'Denver',
       state: 'CO',
       zip: 80203,
       active?: true)
    dog_shop = Merchant.create(name: "Brian's Dog Shop",
       address: '125 Doggo St.',
       city: 'Denver',
       state: 'CO',
       zip: 80210,
       active?: true)

   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

   visit "/admin/merchants"

     within "#merchant-#{bike_shop.id}" do
       expect(page).to have_link(bike_shop.name)
       expect(page).to have_content(bike_shop.city)
       expect(page).to have_content(bike_shop.state)
     end

     within "#merchant-#{dog_shop.id}" do
       expect(page).to have_content(dog_shop.city)
       expect(page).to have_content(dog_shop.state)
       click_link("#{dog_shop.name}")
     end

     expect(current_path).to eq("/admin/merchants/#{dog_shop.id}")
     visit "/admin/merchants"

     within "#merchant-#{bike_shop.id}" do
       click_button("Disable")
     end

     within "#merchant-#{bike_shop.id}" do
       expect(page).to have_button("Enable")
     end
   end
  end
end
