class Discount < ApplicationRecord
  validates_presence_of :name, :quantity_required, :percentage

  belongs_to :merchant

  validates_numericality_of :quantity_required, greater_than: 0
  validates_numericality_of :percentage, greater_than: 0, less_than: 100
end
