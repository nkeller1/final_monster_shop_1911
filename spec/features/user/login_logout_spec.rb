require "rails_helper"

RSpec.describe "as a visitor I can log in" do
  describe "when I visit the login path" do
    it "as a default user I see a field to enter my email and password" do
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

        visit "/login"
        fill_in :email, with: default_user[:email]
        fill_in :password, with: "supersecure1"
        click_button "Sign In"
        expect(current_path).to eq("/profile")
        expect(page).to have_content("Welcome, #{default_user[:name]}")
    end
    it "sees a flash message when login information is incorrect" do
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

        visit "/login"
        fill_in :email, with: default_user[:email]
        fill_in :password, with: "wrongpassword1"
        click_button "Sign In"
        expect(current_path).to eq("/login")
        expect(page).to have_content("Sorry, your credentials are bad.")
    end
    it "as a merchant user I see a field to enter my email and password" do
      merchant_user = User.create({
        name: "Maria R",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariar@example.com",
        password: "supersecure1",
        role: 1
        })

        visit "/login"
        fill_in :email, with: merchant_user[:email]
        fill_in :password, with: "supersecure1"
        click_button "Sign In"
        expect(current_path).to eq("/merchant/dashboard")
        expect(page).to have_content("Welcome, #{merchant_user[:name]}!")
    end
    it "as a admin user I see a field to enter my email and password" do
      admin_user = User.create({
        name: "Dave H",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "davidh@example.com",
        password: "supersecure1",
        role: 2
        })

        visit "/login"
        fill_in :email, with: admin_user[:email]
        fill_in :password, with: "supersecure1"
        click_button "Sign In"
        expect(current_path).to eq("/admin/dashboard")
        expect(page).to have_content("Welcome, #{admin_user[:name]}!")
    end
  end
end
