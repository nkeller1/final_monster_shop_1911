# As an admin
# When I visit the admin's merchant index page ('/admin/merchants')
# I see a "disable" button next to any merchants who are not yet disabled
# When I click on the "disable" button
# I am returned to the admin's merchant index page where I see that the merchant's account is now disabled
# And I see a flash message that the merchant's account is now disabled

require 'rails_helper'

describe "Disable Merchant Account" do
  describe "As an admin" do
    it "Admin can enable and disable a merchant" do
      mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203, active?: true)
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203, active?: true)
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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

      visit "/admin/merchants"

      within "#merchant-#{mike.id}" do
        click_button "Disable"
      end

      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content("#{mike.name} is now disabled")

      within "#merchant-#{meg.id}" do
        expect(page).to have_button("Disable")
      end
      expect(current_path).to eq("/admin/merchants")

      within "#merchant-#{mike.id}" do
        expect(page).not_to have_button("Disable")
        click_button "Enable"
      end

      expect(page).to have_content("#{mike.name} is now enabled")
      expect(current_path).to eq("/admin/merchants")

      within "#merchant-#{mike.id}" do
        expect(page).not_to have_button("Enable")
        expect(page).to have_button("Disable")
      end
    end
  end
end
