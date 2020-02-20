class UsersController < ApplicationController
  def new
  end

  def create
    @new_user = User.new(user_params)
    if @new_user.save
      flash[:success] = "Profile Successfully Created!"
      session[:user_id] = @new_user.id
      redirect_to '/profile'
    else
      flash[:error] = @new_user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    if session[:user_id] == nil
      render file: "/public/404"
    else
      @user = User.find(session[:user_id])
    end
  end

  private
    def user_params
      params.permit(:name, :address, :city, :state, :zip, :email, :password)
    end
end
