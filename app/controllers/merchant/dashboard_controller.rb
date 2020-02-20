class Merchant::DashboardController < ApplicationController
  before_action :require_merchant

  def index
  end

  def require_merchant
    render file: "/public/404" if current_user == nil || !current_user.merchant_user?
  end
end
