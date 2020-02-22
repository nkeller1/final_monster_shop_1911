class UserOrdersController < ApplicationController

  def index
    if current_user && current_user.default_user?
      @orders = current_user.orders
    else
      render 'errors/404'
    end
  end
end
