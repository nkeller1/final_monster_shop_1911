require 'rails_helper'

RSpec.describe "As a User" do
  it "I can edit my profile" do
    default_user = User.create({
      name: "Paul D",
      address: "123 Main St.",
      city: "Broomfield",
      state: "CO",
      zip: "80020",
      email: "pauld@gmail.com",
      password: "supersecure1",
      role: 0
      })
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user)

      visit "/login"
      fill_in :email, with: default_user[:email]
      fill_in :password, with: "supersecure1"
      click_button "Sign In"

      visit '/profile'

      click_link "Edit Profile"

      expect(current_path).to eq('/profile/edit')
      expect(page).to have_selector("input[value='Paul D']")
      expect(page).to have_selector("input[value='123 Main St.']")
      expect(page).to have_selector("input[value='Broomfield']")
      expect(page).to have_selector("input[value='CO']")
      expect(page).to have_selector("input[value='80020']")
      expect(page).to have_selector("input[value='pauld@gmail.com']")

      fill_in :name, with: "Steven D"
      fill_in :email, with: "paul@example.com"

      click_button "Update Profile"

      expect(current_path).to eq('/profile')
      expect(page).to have_content("Your Profile has been Updated!")
      expect(page).to have_content("Steven D")
      expect(page).to have_content("paul@example.com")
    end
  end
