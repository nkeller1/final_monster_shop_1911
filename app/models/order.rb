class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  enum status: %w(Pending Packaged Shipped Cancelled)

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_quantity
    item_orders.sum(:quantity)
  end

  def cancel
    update(status: 'Cancelled')
    item_orders.each do |item_order|
      item_order.update(fulfilled: false)
      item_order.item.update(inventory: item_order.item.inventory + item_order.quantity)
    end
  end

  def order_fulfilled?
    order = item_orders.all? do |item_order|
      item_order.fulfilled == true
    end
    self.update(status: 1) if order
  end
end
