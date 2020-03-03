require 'rails_helper'

describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :items}
    it {should have_many :discounts}
  end

  describe 'instance methods' do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @bike_shop = Merchant.create(
        name: "Brian's Bike Shop",
        address: '123 Bike Rd.',
        city: 'Richmond',
        state: 'VA',
        zip: 11234)

      @dog_shop = Merchant.create(
        name: "Brian's Dog Shop",
        address: '125 Doggo St.',
        city: 'Denver',
        state: 'CO',
        zip: 80210)

      @merchant_user = User.create(
        name: "Maria R",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariaaa@example.com",
        password: "supersecure1",
        role: 1,
        merchant: @bike_shop)
      @default_user_1 = User.create({
          name: "Paul D",
          address: "123 Main St.",
          city: "Broomfield",
          state: "CO",
          zip: "80020",
          email: "mariar@example.com",
          password: "supersecure1",
          role: 0
          })
      @default_user_2 = User.create({
        name: "Default User",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "default@example.com",
        password: "password",
        role: 0
        })
      @default_user_2 = User.create({
        name: "Jacob",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "defaulttt@example.com",
        password: "password",
        role: 0
        })
      @wheels = Item.create(
        name: "Gatorskins",
        description: "They'll never pop!",
        price: 100,
        image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
        inventory: 12,
        merchant: @bike_shop)
     @pencil = Item.create(
       name: "Yellow Pencil",
       description: "You can write on paper with it!",
       price: 2,
       image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
       inventory: 100,
       merchant: @bike_shop)
     @dog_food = Item.create(
        name: "Ol' Roy",
        description: "You can write on paper with it!",
        price: 45,
        image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
        inventory: 100,
        merchant: @dog_shop)

        @order_1 = Order.create(
          name: 'Meg',
          address: '123 Stang Ave',
          city: 'Hershey',
          state: 'PA',
          zip: 17033,
          user: @default_user_1,
          status: 1)
        @order_2 = Order.create(
          name: 'Jon',
          address: '123 Jon Ave',
          city: 'Cool',
          state: 'CO',
          zip: 32525,
          user: @default_user_2,
          status: 1)
        @order_3 = Order.create(
          name: 'Jacob',
          address: '123 Jon Ave',
          city: 'Cool',
          state: 'CO',
          zip: 32525,
          user: @default_user_3,
          status: 1)
        @order_4 = Order.create(
          name: 'Meg',
          address: '123 Stang Ave',
          city: 'Hershey',
          state: 'PA',
          zip: 17033,
          user: @default_user_1,
          status: 0)
        @item_order_1 = ItemOrder.create(
          item: @wheels,
          price: @wheels.price,
          quantity: 2,
          order: @order_1)
        @item_order_2 = ItemOrder.create(
          item: @pencil,
          price: @pencil.price,
          quantity: 1,
          order: @order_2)
        @item_order_3 = ItemOrder.create(
          item: @wheels,
          price: @wheels.price,
          quantity: 1,
          order: @order_2)
        @item_order_4 = ItemOrder.create(
          item: @dog_food,
          price: @dog_food.price,
          quantity: 1,
          order: @order_3)
        @item_order_5 = ItemOrder.create(
          item: @dog_food,
          price: @dog_food.price,
          quantity: 1,
          order: @order_4)
    end
    it 'no_orders' do
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
      expect(@meg.no_orders?).to eq(true)

      order_1 = default_user_1.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      item_order_1 = order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

      expect(@meg.no_orders?).to eq(false)
    end

    it 'item_count' do
      chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 30, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)

      expect(@meg.item_count).to eq(2)
    end

    it 'average_item_price' do
      chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)

      expect(@meg.average_item_price).to eq(70)
    end

    it 'distinct_cities' do
      chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
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
      order_2 = Order.create!(name: 'Brian', address: '123 Brian Ave', city: 'Denver', state: 'CO', zip: 17033, user_id: "#{default_user_1.id}")
      order_3 = Order.create!(name: 'Dao', address: '123 Mike Ave', city: 'Denver', state: 'CO', zip: 17033, user_id: "#{default_user_1.id}")
      order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      order_2.item_orders.create!(item: chain, price: chain.price, quantity: 2)
      order_3.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

      expect(@meg.distinct_cities).to eq(["Denver","Hershey"])
    end
    it "can get pending orders" do
      expect(@bike_shop.pending_orders).to eq([@order_1, @order_2])
    end

    it "enable" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203, active?: false)
      meg.enable
      expect(meg.active?).to eq(true)
    end
    it "disable" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      meg.disable
      expect(meg.active?).to eq(false)
    end
  end
end
