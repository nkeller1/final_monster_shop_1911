class OrdersController <ApplicationController

  def new
  end

  def create
    order = Order.new(order_params)
    current_user.orders << order
    if order.save
      cart.items.each do |item, quantity|
        if item.discounts.empty?
          normal_order(order, item, quantity)
        elsif item.discounts.first.quantity_required > quantity
          normal_order(order, item, quantity)
        elsif item.discounts.first.quantity_required <= quantity
          discount_order(order, item, quantity)
        end
        item.update(inventory:(item.inventory - quantity))
      end
      flash[:success] = "Order was successfully created!"
      session.delete(:cart)
      redirect_to "/profile/orders"
    else
      flash[:error] = "Please complete address form to create an order."
      render :new
    end
  end

  def normal_order(order, item, quantity)
    order.item_orders.create({
      item: item,
      quantity: quantity,
      price: item.price
      })
  end

  def discount_order(order, item, quantity)
    order.item_orders.create({
      item: item,
      quantity: quantity,
      price: (item.price - (item.price * (item.multiple_discounts.first.percentage.to_f / 100)))
      })
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
