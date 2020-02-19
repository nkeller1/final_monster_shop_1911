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
end
