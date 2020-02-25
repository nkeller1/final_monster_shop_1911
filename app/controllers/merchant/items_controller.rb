class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(current_user.merchant_id)
  end

  def activate_deactivate_item
    item = Item.find(params[:item_id])
    if item.active?
      item.update(active?: false)
      flash[:disabled] = "#{item.name} has been Deactivated"
    else
      item.update(active?: true)
      flash[:enabled] = "#{item.name} has been Activated"
    end
    redirect_to '/merchant/items'
  end
end
