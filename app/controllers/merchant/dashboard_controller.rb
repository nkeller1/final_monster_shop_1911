class Merchant::DashboardController < Merchant::BaseController
  def show
    @merchant = Merchant.find(current_user.merchant_id)
  end
end
