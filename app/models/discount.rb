class Discount < ApplicationRecord
  validates_presence_of :name, :quantity_required, :percentage

  belongs_to :merchant

end
