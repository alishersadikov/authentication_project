class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :require_login
  helper_method :current_user

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in?
    @current_user
  end

 def require_login
   unless logged_in?
     flash[:error] = "You must be logged in to access this section"
     redirect_to login_path
   end
 end
end
