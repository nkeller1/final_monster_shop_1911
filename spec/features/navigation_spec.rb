
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')
    end

    it "I can see a cart indicator on all pages" do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      visit '/items'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end
    end
    it "has links to navigate the site in the nav bar" do
      visit '/merchants'

      within 'nav' do
        click_link "Home Page"
        expect(current_path).to eq('/')
      end

      within 'nav' do
        click_link "All Items"
        expect(current_path).to eq('/items')
      end

      within 'nav' do
        click_link "All Merchants"
        expect(current_path).to eq('/merchants')
      end

      within 'nav' do
        expect(page).to have_content("Cart: 0")
        click_link "Cart: 0"
        expect(current_path).to eq('/cart')
      end

      within 'nav' do
        click_link "Login"
        expect(current_path).to eq('/login')
      end

      within 'nav' do
        click_link "Register"
        expect(current_path).to eq('/register')
      end
    end

    describe 'As a default user' do
      it "I see two additonal links, my profile page and log out" do
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


        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user)

        visit root_path

        within 'nav' do
          expect(page).not_to have_content("Login")
          expect(page).not_to have_link("Register")
          expect(page).to have_link("My Profile")
          expect(page).to have_link("Logout")
          expect(page).to have_content("Logged in as #{default_user[:name]}")
        end
      end
    end

    describe "As a merchant user" do
      it "I can see default user links as well as link to merchant dashboard" do
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

        within 'nav' do
          expect(page).to have_link("My Profile")
          expect(page).to have_link("Logout")
          expect(page).not_to have_content("Login")
          expect(page).not_to have_link("Register")
          click_link("Dashboard")
        end
        expect(current_path).to eq('/merchant/dashboard')
      end
    end
  end
end
