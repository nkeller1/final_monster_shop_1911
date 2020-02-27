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
      it "Shows the top 5 most popular active items by quantity purchased, plus quantity bought" do
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
        bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

        #bike_shop items
        tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        paper = bike_shop.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
        pencil = bike_shop.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
        bike = bike_shop.items.create(name: "Bike", description: "Great for riding on!", price: 2000, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 2)
        pump = bike_shop.items.create(name: "Pump", description: "for filling flat tires", price: 25, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 15)

        #dog_shop items
        pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
        dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
        leash = dog_shop.items.create(name: "Dog Leash", description: "They'll Probably Hate it!", price: 9, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 36)
        dog_food = dog_shop.items.create(name: "Dog Food", description: "Food is good", price: 42, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 43, active?: false)
        food_bowl = dog_shop.items.create(name: "Food Bowl", description: "where doggos eat", price: 31, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 52)

        order_1 = default_user_1.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
        order_2 = default_user_1.orders.create!(name: 'Jon', address: '123 Jon Ave', city: 'Cool', state: 'CO', zip: 32525)
        order_3 = default_user_1.orders.create!(name: 'Jacob', address: '123 Jacob Street', city: 'Places', state: 'WY', zip: 23652)
        order_4 = default_user_1.orders.create!(name: 'Jingle', address: '123 Jingle Way', city: 'To', state: 'FL', zip: 23553)
        order_5 = default_user_1.orders.create!(name: 'Hymer', address: '123 Hymer Schmitt', city: 'Live', state: 'CA', zip: 45332)

        order_1.item_orders.create!(item: tire, price: tire.price, quantity: 3)
        order_2.item_orders.create!(item: pencil, price: pencil.price, quantity: 2)
        order_3.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 4)
        order_3.item_orders.create!(item: dog_bone, price: dog_bone.price, quantity: 5)
        order_4.item_orders.create!(item: dog_food, price: dog_food.price, quantity: 7)
        order_5.item_orders.create!(item: bike, price: bike.price, quantity: 1)

        visit '/items'

        within "#statistics" do
          expect(page).to have_content("Statistics")
        end

        within "#stats-top-5" do
          expect(page).to have_content("Top 5 Most Popular Items")
          expect(page).to have_content("#{dog_bone.name}: 5 Purchased")
          expect(page).to have_content("#{pull_toy.name}: 4 Purchased")
          expect(page).to have_content("#{tire.name}: 3 Purchased")
          expect(page).to have_content("#{pencil.name}: 2 Purchased")
          expect(page).to have_content("#{bike.name}: 1 Purchased")
          expect(page).not_to have_content("#{dog_food.name}: 7 Purchased")
        end
      end
    end
  end
end
