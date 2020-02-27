require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :inventory }
    it { should validate_inclusion_of(:active?).in_array([true,false]) }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :reviews}
    it {should have_many :item_orders}
    it {should have_many(:orders).through(:item_orders)}
  end

  describe "instance methods" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      @review_1 = @chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
      @review_2 = @chain.reviews.create(title: "Cool shop!", content: "They have cool bike stuff and I'd recommend them to anyone.", rating: 4)
      @review_3 = @chain.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 1)
      @review_4 = @chain.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      @review_5 = @chain.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 3)
    end

    it "calculate average review" do

      expect(@chain.average_review).to eq(3.0)
    end

    it "sorts reviews" do
      top_three = @chain.sorted_reviews(3,:desc)
      bottom_three = @chain.sorted_reviews(3,:asc)

      expect(top_three).to eq([@review_1,@review_2,@review_5])
      expect(bottom_three).to eq([@review_3,@review_4,@review_5])
    end

    it 'no_orders?' do

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

      expect(@chain.no_orders?).to eq(true)

      order = default_user_1.orders.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)

      order.item_orders.create(item: @chain, price: @chain.price, quantity: 2)
      expect(@chain.no_orders?).to eq(false)
    end
  end
  describe "Class Methods" do
    it ".top_5_items" do
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

      expect(Item.top_5_items[0]).to eq(dog_bone)
      expect(Item.top_5_items[1]).to eq(pull_toy)
      expect(Item.top_5_items[2]).to eq(tire)
      expect(Item.top_5_items[3]).to eq(pencil)
      expect(Item.top_5_items[4]).to eq(bike)
    end

    it ".bottom_5_items" do
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

      expect(Item.bottom_5_items[0]).to eq(bike)
      expect(Item.bottom_5_items[1]).to eq(pencil)
      expect(Item.bottom_5_items[2]).to eq(tire)
      expect(Item.bottom_5_items[3]).to eq(pull_toy)
      expect(Item.bottom_5_items[4]).to eq(dog_bone)
    end
  end
end
