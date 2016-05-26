class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_user
      @current_user ||= if session[:user_id]
        User.find_by_id(session[:user_id])
      end
  end

  def signed_in?
    unless current_user
      redirect_to root_path
    end
  end

  def is_admin?
    if current_user == nil and current_user.admin == nil
      redirect_to root_path, alert: "You need to login as admin to continue."
    end
  end

  helper_method :current_user
end
