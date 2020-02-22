class Merchant::DashboardController < ApplicationController
  before_action :require_merchant

  def show
    user = User.find_by(params[:id])
    @merchant = Merchant.find_by(params[user.merchant_id])
  end

  def require_merchant
    render file: "/public/404" if current_user.nil? || !current_user.merchant_user?
  end
end
