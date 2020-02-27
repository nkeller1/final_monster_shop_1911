class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      user_redirect(user)
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:cart] = Hash.new(0)
    flash[:success] = "You have logged out."
    redirect_to '/'
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
end
