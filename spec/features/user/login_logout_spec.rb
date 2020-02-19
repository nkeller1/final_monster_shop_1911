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
        visit '/login'
        expect(current_path).to eq("/profile")
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
        visit '/login'
        expect(current_path).to eq("/merchant/dashboard")
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
        visit '/login'
        expect(current_path).to eq("/admin/dashboard")
    end

    it "can log out" do
      default_user = User.create({
        name: "Paul D",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "example@example.com",
        password: "supersecure1",
        role: 0
        })

      mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)

      paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
      pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

       visit "/login"

       fill_in :email, with: default_user[:email]
       fill_in :password, with: "supersecure1"
       click_button "Sign In"

       visit "/items/#{paper.id}"
       click_on "Add To Cart"

       visit "/items/#{pencil.id}"
       click_on "Add To Cart"

       click_link "Logout"

       expect(current_path).to eq('/')
       expect(page).to have_content("You have logged out.")
       expect(page).to have_content("Cart: 0")
    end
  end
end
