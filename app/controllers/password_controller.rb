class PasswordController < ApplicationController
  def edit
    @user = User.find(session[:user_id])
  end

  def update
    user = User.find(session[:user_id])
    if params[:password] == params[:password_confirmation]
      user.update(password_params)
      user.save
      flash[:success] = "Your Password has been Updated!"
      redirect_to "/profile"
    else
      flash[:error] = "Passwords do not match. Try again."
      redirect_to '/password/edit'
    end
  end

  private

    def password_params
      params.permit(:password)
    end
end
