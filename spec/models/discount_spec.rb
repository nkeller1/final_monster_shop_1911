require 'rails_helper'

describe Discount, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :quantity_required}
    it {should validate_presence_of :percentage}
  end

  describe 'relationships' do
    it {should belong_to :merchant}
    it {should belong_to :item}
  end
end
