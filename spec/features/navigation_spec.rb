
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
  end
end


# As a visitor
# I see a navigation bar
# This navigation bar includes links for the following:
# - a link to return to the welcome / home page of the application ("/")
# - a link to browse all items for sale ("/items")
# - a link to see all merchants ("/merchants")
# - a link to my shopping cart ("/cart")
# - a link to log in ("/login")
# - a link to the user registration page ("/register")
#
# Next to the shopping cart link I see a count of the items in my cart
