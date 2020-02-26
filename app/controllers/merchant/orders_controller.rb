class Merchant::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @item_orders = @order.merchant_items_on_order(current_user.merchant_id)
  end
end
