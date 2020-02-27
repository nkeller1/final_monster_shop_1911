class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  enum status: %w(Packaged Pending Shipped Cancelled)

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
    update(status: 0) if item_orders.where(fulfilled: false).empty?
  end

  def merchant_items_on_order(merchant_id)
    item_orders.joins(:item)
    .where(items: {merchant_id: merchant_id})
  end
end
