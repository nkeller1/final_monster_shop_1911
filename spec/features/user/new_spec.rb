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
    fill_in :password_confirmation, with: new_user[:password]

    click_button "Submit Form"

    expect(current_path).to eq('/profile')
    expect(page).to have_content("Profile Successfully Created!")
    end

    it "shows message when form is not filled out properly" do
      visit '/register'

      new_user = ({name: "Paul D",
                address: "123 Main St.",
                city: "Broomfield",
                state: "CO",
                zip: "80020",
                email: "pauld@gmail.com",
                password: "supersecure1"})

      fill_in :name, with: ""
      fill_in :address, with: new_user[:address]
      fill_in :city, with: new_user[:city]
      fill_in :state, with: ""
      fill_in :zip, with: new_user[:zip]
      fill_in :email, with: new_user[:email]
      fill_in :password, with: new_user[:password]
      fill_in :password_confirmation, with: new_user[:password]

      click_button "Submit Form"

      expect(current_path).to eq('/register')
      expect(page).to have_content("Name can't be blank and State can't be blank")
    end

    it "cannot save form without unique email" do
      user_1 = User.create({name: "Paul D",
                address: "123 Main St.",
                city: "Broomfield",
                state: "CO",
                zip: "80020",
                email: "pauld@gmail.com",
                password: "supersecure1"})

      visit '/register'

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
      fill_in :email, with: "pauld@gmail.com"
      fill_in :password, with: new_user[:password]
      fill_in :password_confirmation, with: new_user[:password]

      click_button "Submit Form"

      expect(current_path).to eq('/register')
      expect(page).to have_content("Email has already been taken")
      expect(page).to have_selector("input[value='Paul D']")
      expect(page).to have_selector("input[value='123 Main St.']")
      expect(page).to have_selector("input[value='Broomfield']")
      expect(page).to have_selector("input[value='CO']")
      expect(page).to have_selector("input[value='80020']")
    end
  end
end
