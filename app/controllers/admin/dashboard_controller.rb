class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def update
    order = Order.find(params[:order_id])
    order.update(status: 2)
    redirect_to '/admin'
  end
end
