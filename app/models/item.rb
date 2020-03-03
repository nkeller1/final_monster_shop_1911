class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders
  has_many :discounts, dependent: :destroy

  validates_presence_of :name,
                        :description,
                        :price,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]

  validates_numericality_of :price, greater_than: -1
  validates_numericality_of :inventory, greater_than: -1

  before_save :set_defaults

  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def self.top_5_items
    item = Item.where(active?: true)
    item.joins(:item_orders)
    .select("items.*, sum(item_orders.quantity) as total_quantity")
    .group("items.id")
    .order("total_quantity desc")
    .limit(5)
  end

  def self.bottom_5_items
    item = Item.where(active?: true)
    item.joins(:item_orders)
    .select("items.*, sum(item_orders.quantity) as total_quantity")
    .group("items.id")
    .order("total_quantity asc")
    .limit(5)
  end

  def set_defaults
    self.image = 'https://cdn.mos.cms.futurecdn.net/rqoDpnCCrdpGFHM6qky3rS-1200-80.jpg' if self.image == "" || nil
  end

  def multiple_discounts
    discounts.order('discounts.percentage DESC')
  end

  def discount_price
    (self.price - (self.price * (self.multiple_discounts.first.percentage.to_f / 100)))
  end
end
