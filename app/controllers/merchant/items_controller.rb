class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(current_user.merchant_id)
  end
end
