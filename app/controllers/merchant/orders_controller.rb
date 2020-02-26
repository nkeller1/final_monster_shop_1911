class Merchant::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @item_orders = @order.merchant_items_on_order(current_user.merchant_id)
  end

  def fulfill
    item_order = ItemOrder.find(params[:order_id])
    item_order.update(fulfilled: true)
    flash[:sweet] = "Item on Order Fulfilled"
    redirect_to "/merchant/orders/#{item_order.order.id}"
  end
end
