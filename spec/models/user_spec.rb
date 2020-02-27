require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :password}
  end

  it "can test if the user has an order" do
    default_user = User.create!({
      name: "Paul D",
      address: "123 Main St.",
      city: "Broomfield",
      state: "CO",
      zip: "80020",
      email: "mariar@example.com",
      password: "supersecure1",
      role: 0
      })

    expect(default_user.has_order?).to eq(false)

    order_1 = default_user.orders.create(
      name: 'Meg',
      address: '123 Stang Ave',
      city: 'Hershey',
      state: 'PA',
      zip: 17033,
      status: 0)

    expect(default_user.has_order?).to eq(true)
<<<<<<< HEAD
=======

>>>>>>> 181b99ff1effa7e47247da6757084d7fdc942647
  end
end
