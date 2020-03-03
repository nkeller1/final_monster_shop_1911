require 'rails_helper'

RSpec.describe Cart do
  describe 'Instance Methods' do

    it ".total_items" do
      bike_shop = Merchant.create(
        name: "Brian's Bike Shop",
        address: '123 Bike Rd.',
        city: 'Richmond',
        state: 'VA',
        zip: 11234)

      merchant_user = User.create(
        name: "Maria R",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariaaa@example.com",
        password: "supersecure1",
        role: 1,
        merchant: bike_shop)

      default_user_1 = User.create({
        name: "Paul D",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariar@example.com",
        password: "supersecure1",
        role: 0
        })

      wheels = Item.create(
        name: "Gatorskins",
        description: "They'll never pop!",
        price: 100,
        image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
        inventory: 12,
        merchant: bike_shop)

      pencil = Item.create(
         name: "Yellow Pencil",
         description: "You can write on paper with it!",
         price: 10,
         image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
         inventory: 100,
         merchant: bike_shop)

      discount_1 = Discount.create(
        name: 'Pencil Discount',
        quantity_required: 10,
        percentage: 10,
        merchant: bike_shop,
        item: pencil
      )

      discount_2 = Discount.create(
        name: 'Wheels Discount',
        quantity_required: 5,
        percentage: 5,
        merchant: bike_shop,
        item: wheels
      )

      cart = Cart.new({
      pencil.id.to_s => 1,
      wheels.id.to_s => 2
      })

      expect(cart.total_items).to eq(3)
    end

    it ".items" do
      Item.destroy_all
      bike_shop = Merchant.create(
        name: "Brian's Bike Shop",
        address: '123 Bike Rd.',
        city: 'Richmond',
        state: 'VA',
        zip: 11234)

      merchant_user = User.create(
        name: "Maria R",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariaaa@example.com",
        password: "supersecure1",
        role: 1,
        merchant: bike_shop)

      default_user_1 = User.create({
        name: "Paul D",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariar@example.com",
        password: "supersecure1",
        role: 0
        })

      wheels = Item.create(
        name: "Gatorskins",
        description: "They'll never pop!",
        price: 100,
        image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
        inventory: 12,
        merchant: bike_shop)

      pencil = Item.create(
         name: "Yellow Pencil",
         description: "You can write on paper with it!",
         price: 10,
         image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
         inventory: 100,
         merchant: bike_shop)

      discount_1 = Discount.create(
        name: 'Pencil Discount',
        quantity_required: 10,
        percentage: 10,
        merchant: bike_shop,
        item: pencil
      )

      discount_2 = Discount.create(
        name: 'Wheels Discount',
        quantity_required: 5,
        percentage: 5,
        merchant: bike_shop,
        item: wheels
      )
      cart = Cart.new({
      pencil.id.to_s => 1,
      })

      expect(cart.items.keys.first).to eq(pencil)
    end

    it ".items" do
      Item.destroy_all
      bike_shop = Merchant.create(
        name: "Brian's Bike Shop",
        address: '123 Bike Rd.',
        city: 'Richmond',
        state: 'VA',
        zip: 11234)

      merchant_user = User.create(
        name: "Maria R",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariaaa@example.com",
        password: "supersecure1",
        role: 1,
        merchant: bike_shop)

      default_user_1 = User.create({
        name: "Paul D",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariar@example.com",
        password: "supersecure1",
        role: 0
        })

      wheels = Item.create(
        name: "Gatorskins",
        description: "They'll never pop!",
        price: 100,
        image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
        inventory: 12,
        merchant: bike_shop)

      pencil = Item.create(
         name: "Yellow Pencil",
         description: "You can write on paper with it!",
         price: 10,
         image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
         inventory: 100,
         merchant: bike_shop)

      discount_1 = Discount.create(
        name: 'Pencil Discount',
        quantity_required: 10,
        percentage: 10,
        merchant: bike_shop,
        item: pencil
      )

      discount_2 = Discount.create(
        name: 'Wheels Discount',
        quantity_required: 5,
        percentage: 5,
        merchant: bike_shop,
        item: wheels
      )

      cart = Cart.new({
      pencil.id.to_s => 1,
      wheels.id.to_s => 2
      })

      expect(cart.subtotal(pencil)).to eq(10)
    end

    it ".total" do
      Item.destroy_all
      bike_shop = Merchant.create(
        name: "Brian's Bike Shop",
        address: '123 Bike Rd.',
        city: 'Richmond',
        state: 'VA',
        zip: 11234)

      merchant_user = User.create(
        name: "Maria R",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariaaa@example.com",
        password: "supersecure1",
        role: 1,
        merchant: bike_shop)

      default_user_1 = User.create({
        name: "Paul D",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariar@example.com",
        password: "supersecure1",
        role: 0
        })

      wheels = Item.create(
        name: "Gatorskins",
        description: "They'll never pop!",
        price: 100,
        image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
        inventory: 12,
        merchant: bike_shop)

      pencil = Item.create(
         name: "Yellow Pencil",
         description: "You can write on paper with it!",
         price: 10,
         image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
         inventory: 100,
         merchant: bike_shop)

      discount_1 = Discount.create(
        name: 'Pencil Discount',
        quantity_required: 10,
        percentage: 10,
        merchant: bike_shop,
        item: pencil
      )

      cart = Cart.new({
      pencil.id.to_s => 1,
      wheels.id.to_s => 2
      })

      cart2 = Cart.new({
      pencil.id.to_s => 10,
      })

      cart3 = Cart.new({
      wheels.id.to_s => 10,
      })

      expect(cart.total).to eq(210)
      expect(cart2.total).to eq(90.0)
      expect(cart3.total).to eq(1000)
    end

    it ".limit_reached" do
      Item.destroy_all
      bike_shop = Merchant.create(
        name: "Brian's Bike Shop",
        address: '123 Bike Rd.',
        city: 'Richmond',
        state: 'VA',
        zip: 11234)

      merchant_user = User.create(
        name: "Maria R",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariaaa@example.com",
        password: "supersecure1",
        role: 1,
        merchant: bike_shop)

      default_user_1 = User.create({
        name: "Paul D",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariar@example.com",
        password: "supersecure1",
        role: 0
        })

      wheels = Item.create(
        name: "Gatorskins",
        description: "They'll never pop!",
        price: 100,
        image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
        inventory: 12,
        merchant: bike_shop)

      pencil = Item.create(
         name: "Yellow Pencil",
         description: "You can write on paper with it!",
         price: 10,
         image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
         inventory: 100,
         merchant: bike_shop)

      discount_1 = Discount.create(
        name: 'Pencil Discount',
        quantity_required: 10,
        percentage: 10,
        merchant: bike_shop,
        item: pencil
      )

      discount_2 = Discount.create(
        name: 'Wheels Discount',
        quantity_required: 5,
        percentage: 5,
        merchant: bike_shop,
        item: wheels
      )

      cart = Cart.new({
      pencil.id.to_s => 1,
      wheels.id.to_s => 2
      })

      expect(cart.limit_reached?(pencil.id)).to eq(nil)
    end

    it ".quantity_zero" do
      Item.destroy_all
      bike_shop = Merchant.create(
        name: "Brian's Bike Shop",
        address: '123 Bike Rd.',
        city: 'Richmond',
        state: 'VA',
        zip: 11234)

      merchant_user = User.create(
        name: "Maria R",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariaaa@example.com",
        password: "supersecure1",
        role: 1,
        merchant: bike_shop)

      default_user_1 = User.create({
        name: "Paul D",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariar@example.com",
        password: "supersecure1",
        role: 0
        })

      wheels = Item.create(
        name: "Gatorskins",
        description: "They'll never pop!",
        price: 100,
        image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
        inventory: 12,
        merchant: bike_shop)

      pencil = Item.create(
         name: "Yellow Pencil",
         description: "You can write on paper with it!",
         price: 10,
         image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
         inventory: 100,
         merchant: bike_shop)

      discount_1 = Discount.create(
        name: 'Pencil Discount',
        quantity_required: 10,
        percentage: 10,
        merchant: bike_shop,
        item: pencil
      )

      discount_2 = Discount.create(
        name: 'Wheels Discount',
        quantity_required: 5,
        percentage: 5,
        merchant: bike_shop,
        item: wheels
      )

      cart = Cart.new({
      pencil.id.to_s => 1,
      wheels.id.to_s => 2
      })

      expect(cart.quantity_zero?(pencil.id)).to eq(nil)
    end

    it ".add_item" do
      Item.destroy_all
      bike_shop = Merchant.create(
        name: "Brian's Bike Shop",
        address: '123 Bike Rd.',
        city: 'Richmond',
        state: 'VA',
        zip: 11234)

      merchant_user = User.create(
        name: "Maria R",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariaaa@example.com",
        password: "supersecure1",
        role: 1,
        merchant: bike_shop)

      default_user_1 = User.create({
        name: "Paul D",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariar@example.com",
        password: "supersecure1",
        role: 0
        })

      wheels = Item.create(
        name: "Gatorskins",
        description: "They'll never pop!",
        price: 100,
        image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
        inventory: 12,
        merchant: bike_shop)

      pencil = Item.create(
         name: "Yellow Pencil",
         description: "You can write on paper with it!",
         price: 10,
         image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
         inventory: 100,
         merchant: bike_shop)

      discount_1 = Discount.create(
        name: 'Pencil Discount',
        quantity_required: 10,
        percentage: 10,
        merchant: bike_shop,
        item: pencil
      )

      discount_2 = Discount.create(
        name: 'Wheels Discount',
        quantity_required: 5,
        percentage: 5,
        merchant: bike_shop,
        item: wheels
      )

      cart = Cart.new({
      pencil.id.to_s => 1,
      wheels.id.to_s => 2
      })

      expect(cart.add_item(pencil.id.to_s)).to eq(2)
    end

    it ".add_quantity" do
      Item.destroy_all
      bike_shop = Merchant.create(
        name: "Brian's Bike Shop",
        address: '123 Bike Rd.',
        city: 'Richmond',
        state: 'VA',
        zip: 11234)

      merchant_user = User.create(
        name: "Maria R",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariaaa@example.com",
        password: "supersecure1",
        role: 1,
        merchant: bike_shop)

      default_user_1 = User.create({
        name: "Paul D",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariar@example.com",
        password: "supersecure1",
        role: 0
        })

      wheels = Item.create(
        name: "Gatorskins",
        description: "They'll never pop!",
        price: 100,
        image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
        inventory: 12,
        merchant: bike_shop)

      pencil = Item.create(
         name: "Yellow Pencil",
         description: "You can write on paper with it!",
         price: 10,
         image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
         inventory: 100,
         merchant: bike_shop)

      discount_1 = Discount.create(
        name: 'Pencil Discount',
        quantity_required: 10,
        percentage: 10,
        merchant: bike_shop,
        item: pencil
      )

      discount_2 = Discount.create(
        name: 'Wheels Discount',
        quantity_required: 5,
        percentage: 5,
        merchant: bike_shop,
        item: wheels
      )

      cart = Cart.new({
      pencil.id.to_s => 1,
      wheels.id.to_s => 2
      })

      expect(cart.add_quantity(pencil.id.to_s)).to eq(2)
    end

    it ".subtract_quantity" do
      Item.destroy_all
      bike_shop = Merchant.create(
        name: "Brian's Bike Shop",
        address: '123 Bike Rd.',
        city: 'Richmond',
        state: 'VA',
        zip: 11234)

      merchant_user = User.create(
        name: "Maria R",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariaaa@example.com",
        password: "supersecure1",
        role: 1,
        merchant: bike_shop)

      default_user_1 = User.create({
        name: "Paul D",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariar@example.com",
        password: "supersecure1",
        role: 0
        })

      wheels = Item.create(
        name: "Gatorskins",
        description: "They'll never pop!",
        price: 100,
        image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
        inventory: 12,
        merchant: bike_shop)

      pencil = Item.create(
         name: "Yellow Pencil",
         description: "You can write on paper with it!",
         price: 10,
         image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
         inventory: 100,
         merchant: bike_shop)

      discount_1 = Discount.create(
        name: 'Pencil Discount',
        quantity_required: 10,
        percentage: 10,
        merchant: bike_shop,
        item: pencil
      )

      discount_2 = Discount.create(
        name: 'Wheels Discount',
        quantity_required: 5,
        percentage: 5,
        merchant: bike_shop,
        item: wheels
      )

      cart = Cart.new({
      pencil.id.to_s => 2,
      wheels.id.to_s => 2
      })

      expect(cart.subtract_quantity(pencil.id.to_s)).to eq(1)
    end
    it ".subtotal" do
      Item.destroy_all
      bike_shop = Merchant.create(
        name: "Brian's Bike Shop",
        address: '123 Bike Rd.',
        city: 'Richmond',
        state: 'VA',
        zip: 11234)

      merchant_user = User.create(
        name: "Maria R",
        address: "321 Notmain Rd.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariaaa@example.com",
        password: "supersecure1",
        role: 1,
        merchant: bike_shop)

      default_user_1 = User.create({
        name: "Paul D",
        address: "123 Main St.",
        city: "Broomfield",
        state: "CO",
        zip: "80020",
        email: "mariar@example.com",
        password: "supersecure1",
        role: 0
        })

     pencil = Item.create(
       name: "Yellow Pencil",
       description: "You can write on paper with it!",
       price: 10,
       image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg",
       inventory: 100,
       merchant: bike_shop)

     wheels = Item.create(
       name: "Gatorskins",
       description: "They'll never pop!",
       price: 100,
       image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
       inventory: 12,
       merchant: bike_shop)

     something = Item.create(
       name: "Fake",
       description: "Something",
       price: 50,
       image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",
       inventory: 100,
       merchant: bike_shop)


     discount_1 = Discount.create(
       name: 'Pencil Discount',
       quantity_required: 10,
       percentage: 10,
       merchant: bike_shop,
       item: pencil
     )

     cart = Cart.new({
       pencil.id.to_s => 10,
       wheels.id.to_s => 2,
       something.id.to_s => 1
       })

      expect(cart.subtotal(wheels)).to eq(200)
      expect(cart.subtotal(pencil)).to eq(90)
      expect(cart.subtotal(something)).to eq(50)
    end
  end
end
