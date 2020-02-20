class Default::BaseController < ApplicationController
  before_action :require_default

  def require_default
    render file: "/public/404" if current_user.nil? || !current_user.default_user?
  end
end
