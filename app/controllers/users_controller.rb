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
      flash[:error] =  @new_user.errors.full_messages.uniq do |error|
        error
      end.to_sentence
      render :new
    end
  end

  def show
    if current_user.nil?
      render file: "/public/404"
    else
      @user = User.find(current_user.id)
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    user = User.find(session[:user_id])
    user.update(user_params)
    if user.save
      flash[:success] = "Your Profile has been Updated!"
      redirect_to "/profile"
    else
      flash[:error] = "Email address is already in use."
      redirect_to "/profile/edit"
    end
  end

  private
    def user_params
      params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
    end
end
