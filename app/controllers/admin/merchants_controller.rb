class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def enable_disable_merchant
    merchant = Merchant.find(params[:merchant_id])
    if merchant.active?
      merchant.disable
      flash[:error] = "#{merchant.name} is now disabled"
    else
      merchant.enable
      flash[:success] = "#{merchant.name} is now enabled"
    end
    redirect_to '/admin/merchants'
  end
end
