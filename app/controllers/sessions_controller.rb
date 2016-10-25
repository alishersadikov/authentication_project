class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    # user = User.find_by(email: params[:session][:email].downcase)
    user = User.authenticate(params[:session][:email].downcase, params[:session][:password])
    if user
      log_in user
      flash[:success] = "Welcome to the App!"
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
   log_out
   redirect_to root_url
  end
end
