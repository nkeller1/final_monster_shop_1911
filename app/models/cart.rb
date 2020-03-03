class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def add_item(item)
    @contents[item] = 0 if !@contents[item]
    @contents[item] += 1
  end

  def total_items
    @contents.values.sum
  end

  def items
    item_quantity = {}
    @contents.each do |item_id,quantity|
      item_quantity[Item.find(item_id)] = quantity
    end
    item_quantity
  end

  def subtotal(item)
    if item.discounts.empty?
      item.price * @contents[item.id.to_s]
    elsif item.discounts.first.quantity_required > @contents[item.id.to_s]
      item.price * @contents[item.id.to_s]
    elsif item.discounts.first.quantity_required <= @contents[item.id.to_s]
      calculate_discounted_percent(item, @contents[item.id.to_s])
    end
  end

  def total
    @contents.sum do |item_id, quantity|
      item = Item.find(item_id)
      if item.discounts.empty?
        calculate_percent(item, quantity)
      elsif item.discounts.first.quantity_required > quantity
        calculate_percent(item, quantity)
      elsif item.discounts.first.quantity_required <= quantity
        calculate_discounted_percent(item, quantity)
      end
    end
  end

  def add_quantity(item)
    @contents[item] += 1
  end

  def subtract_quantity(item)
    @contents[item] -= 1
  end

  def limit_reached?(item)
    return @contents[item] if @contents[item] == (Item.find(item).inventory)
  end

  def quantity_zero?(item)
    return true if @contents[item] == 0
  end

  def calculate_percent(item, quantity)
    item.price * quantity
  end

  def calculate_discounted_percent(item, quantity)
    (item.price - (item.price * (item.multiple_discounts.first.percentage.to_f / 100))) * quantity.to_f
  end
end
