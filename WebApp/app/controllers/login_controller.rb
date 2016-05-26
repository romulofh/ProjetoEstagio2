class LoginController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      session[:user_id] = user.id
      redirect_to home_index_path
    else
      flash.now[:alert] = "invalid email or password"
      render action: "new"
    end
  end
  def destroy
    session.delete(:user_id)
    user = nil
    redirect_to root_url
  end
end
