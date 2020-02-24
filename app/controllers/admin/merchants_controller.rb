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
      merchant.update(active?: false)
      flash[:disabled] = "#{merchant.name} is now disabled"
    else
      merchant.update(active?: true)
      flash[:enabled] = "#{merchant.name} is now enabled"
    end
    redirect_to '/admin/merchants'
  end
end
