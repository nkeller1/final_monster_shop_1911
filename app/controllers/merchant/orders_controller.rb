class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find(params[:id])
    @item_orders = @order.merchant_items_on_order(current_user.merchant_id)
  end

  def fulfill
    order = Order.find(params[:order_id])
    item_order = ItemOrder.find(params[:item_order_id])
    item_order.update(fulfilled: true)
    flash[:success] = "Item on Order Fulfilled"
    order_fulfilled?(order)
    redirect_to "/merchant/orders/#{item_order.order.id}"
  end

  def order_fulfilled?(order)
    package_order = order.item_orders.where(fulfilled: false).empty?
    order.update(status: "Packaged") if package_order
  end
end
