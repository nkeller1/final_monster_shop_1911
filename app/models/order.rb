class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  enum status: %w(Pending Shipped Cancelled)

  def grandtotal
    item_orders.sum('price * quantity')
  end
end
