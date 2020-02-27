class Merchant::BaseController < ApplicationController
  before_action :require_merchant
  def require_merchant
    render file: "/public/404" if current_user.nil? || !current_user.merchant_user?
  end
end
