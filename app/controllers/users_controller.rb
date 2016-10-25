class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :show, :create]


  def index
  end

  def new
    @user = User.new()
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def secret
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
