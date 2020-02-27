require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
  end

  describe 'instance methods' do
    before :each do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins",
            description: "They'll never pop!",
            price: 100,
            image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
            inventory: 10)

      @pull_toy = @brian.items.create(name: "Pull Toy",
            description: "Great pull toy!",
            price: 10,
            image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg",
            inventory: 32)

      @default_user_1 = User.create({
        name: "Paul D",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "pauld@example.com",
        password: "supersecure1",
        role: 0
        })
      @order_1 = @default_user_1.orders.create(
        name: 'Meg',
        address: '123 Stang Ave',
        city: 'Hershey',
        state: 'PA',
        zip: 17033,
        status: 0)

      @item_order_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, fulfilled: true)
      @item_order_2 = @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3, fulfilled: false)
    end

    it 'can calculate the grandtotal' do
      expect(@order_1.grandtotal).to eq(230)
    end

    it "can count the total_quantity" do
      expect(@order_1.total_quantity).to eq(5)
    end

    it 'test order status' do
      default_user_1 = User.create!({
        name: "Paul D",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariar@example.com",
        password: "supersecure1",
        role: 0
        })

      order_1 = default_user_1.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 1)

      expect(order_1.status).to eq("Pending")

      order_2 = default_user_1.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 0)

      expect(order_2.status).to eq("Packaged")

      order_3 = default_user_1.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 2)

      expect(order_3.status).to eq("Shipped")

      order_4 = default_user_1.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 3)

      expect(order_4.status).to eq("Cancelled")
    end

    it "cancel" do
      expect(@item_order_1.item.inventory).to eq(10)
      expect(@item_order_1.fulfilled).to eq(true)

       @order_1.cancel

       @order_1.reload

       expect(@order_1.status).to eq('Cancelled')

       @order_1.item_orders.each do |item_order|
         expect(@item_order_1.fulfilled).to eq(false)
         expect(@item_order_1.item.inventory).to eq(12)
       end
    end

    it "can see if an order has been fulfilled" do
      order = @default_user_1.orders.create(
        name: 'Meg',
        address: '123 Stang Ave',
        city: 'Hershey',
        state: 'PA',
        zip: 17033,
        status: 1)

      item_order_1 = order.item_orders.create!(
        item: @tire,
        price: @tire.price,
        quantity: 2,
        fulfilled: false)

      item_order_2 = order.item_orders.create!(
        item: @pull_toy,
        price: @pull_toy.price,
        quantity: 3,
        fulfilled: false)

      expect(order.item_orders.where(fulfilled: false).empty?).to eq(false)

      order_2 = @default_user_1.orders.create(
        name: 'Meg',
        address: '123 Stang Ave',
        city: 'Hershey',
        state: 'PA',
        zip: 17033,
        status: 0)

      item_order_1 = order_2.item_orders.create!(
        item: @tire,
        price: @tire.price,
        quantity: 2,
        fulfilled: true)

      item_order_2 = order_2.item_orders.create!(
        item: @pull_toy,
        price: @pull_toy.price,
        quantity: 3,
        fulfilled: true)


      expect(order_2.status).to eq("Packaged")
      expect(order_2.order_fulfilled?).to eq(true)
    end

    it "can test merchant items on orders" do
      merchant_id = @pull_toy.merchant_id

      expect(@order_1.merchant_items_on_order(merchant_id)).to eq([@item_order_2])
    end
  end
end
