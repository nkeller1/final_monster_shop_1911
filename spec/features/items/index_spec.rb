require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
    end

    it "all items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)
      expect(page).not_to have_link(@dog_bone.name)
    end

    it "I can see a list of all of the items "do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

      expect(page).not_to have_link(@dog_bone.name)
      expect(page).not_to have_content(@dog_bone.description)
      expect(page).not_to have_css("img[src*='#{@dog_bone.image}']")
    end

    it "item images link to that items show page" do
      visit '/items'

      within "#item-#{@pull_toy.id}" do
        find(:xpath, "//a/img[@alt='Tug toy dog pull 9010 2 800x800']/..").click
      end
      expect(current_path).to eq("/items/#{@pull_toy.id}")
    end

    describe "I see an area with statistics" do
      it "Shows the top 5 most popular items by quantity purchased, plus quantity bought" do
        default_user_1 = User.create({
          name: "Paul D",
          address: "123 Main St.",
          city: "Broomfield",
          state: "CO",
          zip: "80020",
          email: "pauld@example.com",
          password: "supersecure1",
          role: 0
          })
        order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: "#{default_user_1.id}")

        order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

        visit '/items'

        within "#statistics" do
          expect(page).to have_content("Statistics")
        end

        within "#stats-top-5" do
          expect(page).to have_content("Top 5 Most Popular Items")
          expect(page).to have_content("#{@tire.name}: 2 Purchased")
        end
      end
    end
  end
end
