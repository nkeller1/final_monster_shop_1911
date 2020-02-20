class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart, :current_user, :user_redirect, :no_admin, :authorize

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_redirect(user)
    if user.admin_user?
      redirect_to "/admin"
    elsif user.merchant_user?
      redirect_to "/merchant"
    else
      redirect_to "/profile"
    end
  end

  def authorize
    render file: "/public/404" if current_user.nil?
  end

  def no_admin
    render file: "/public/404" if current_user && current_user.role == 'admin user'
  end
end
