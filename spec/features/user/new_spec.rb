require 'rails_helper'

RSpec.describe "New User Form" do
  describe "As a visitor" do
    it "I click on register link in nav bar" do
      visit '/merchants'

      within '.topnav' do
        click_link "Register"
      end

    expect(current_path).to eq('/register')

    new_user = ({name: "Paul D",
              address: "123 Main St.",
              city: "Broomfield",
              state: "CO",
              zip: "80020",
              email: "pauld@gmail.com",
              password: "supersecure1"})

    fill_in :name, with: new_user[:name]
    fill_in :address, with: new_user[:address]
    fill_in :city, with: new_user[:city]
    fill_in :state, with: new_user[:state]
    fill_in :zip, with: new_user[:zip]
    fill_in :email, with: new_user[:email]
    fill_in :password, with: new_user[:password]
    fill_in :confirm_password, with: new_user[:password]

    click_button "Submit Form"

    expect(current_path).to eq('/profile')
    expect(page).to have_content("Profile Successfully Created!")
    end
  end
end
