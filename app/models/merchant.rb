class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :item_orders, through: :items
  has_many :discounts, dependent: :destroy

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip


  def no_orders?
    item_orders.empty?
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    item_orders.distinct.joins(:order).pluck(:city)
  end

  def pending_orders
     Order.joins(:items).where(items: {merchant_id: self.id}).where(orders: {status: "Pending"}).distinct
  end

  def enable
    self.update(active?: true)
    self.items.update_all(active?: true)
  end

  def disable
    self.update(active?: false)
    self.items.update_all(active?: false)
  end
end
