class Admin::BaseController < ApplicationController
  before_action :require_admin
  def require_admin
    render file: "/public/404" if current_user == nil || !current_user.admin_user?
  end
end
