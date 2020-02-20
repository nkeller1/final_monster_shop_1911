require 'rails_helper'

RSpec.describe "As a User" do
  it "I can see my profile page" do
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


      expect(page).to have_content(default_user.name)
      expect(page).to have_content(default_user.address)
      expect(page).to have_content(default_user.city)
      expect(page).to have_content(default_user.state)
      expect(page).to have_content(default_user.zip)
      expect(page).to have_content(default_user.email)
      expect(page).to have_link("Edit Profile")
  end
end
