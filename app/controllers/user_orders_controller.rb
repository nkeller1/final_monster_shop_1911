class UserOrdersController < ApplicationController

  def index
    if current_user && current_user.default_user? || current_user.merchant_user?
      @orders = current_user.orders
    else
      render 'errors/404'
    end
  end

  def show
    @order = Order.find(params[:order_id])
    @order.order_fulfilled?
  end

  def destroy
    order = Order.find(params[:order_id])
    order.cancel
    flash[:notice] = "Your Order has been Cancelled. :("
    redirect_to '/profile'
  end
end
