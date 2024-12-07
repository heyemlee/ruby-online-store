class RegistrationsController < ApplicationController
  skip_before_action :authorize
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.admin = false 

    if @user.save
      session[:user_id] = @user.id
      redirect_to store_index_url, notice: 'Registration successful! Welcome to our store.'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end 