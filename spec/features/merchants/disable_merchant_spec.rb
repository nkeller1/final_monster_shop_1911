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

    it "Disable and Enabling a merchant account also enables/disables it's items" do
      mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203, active?: true)
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203, active?: true)

      pump = meg.items.create(name: "Pump",
                                  description: "for filling flat tires",
                                  price: 25,
                                  image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
                                  inventory: 15,
                                  active?: true)

      pull_toy = mike.items.create(name: "Pull Toy",
                                  description: "Great pull toy!",
                                  price: 10,
                                  image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg",
                                  inventory: 32,
                                  active?: true)

      dog_bone = mike.items.create(name: "Dog Bone",
                                  description: "They'll love it!",
                                  price: 21,
                                  image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg",
                                  inventory: 21,
                                  active?: true)

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

      visit "/items"

      expect(page).not_to have_content("#{pull_toy.name}")
      expect(page).not_to have_content("#{dog_bone.name}")

      within "#item-#{pump.id}" do
        expect(page).to have_content("Active")
      end
    end
  end
end
