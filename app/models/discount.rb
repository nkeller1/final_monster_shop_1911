class Discount < ApplicationRecord
  validates_presence_of :name, :quantity_required, :percentage, :item

  belongs_to :merchant
  belongs_to :item

  validates_numericality_of :quantity_required, greater_than: 0
  validates_numericality_of :percentage, greater_than: 0, less_than: 100
end
