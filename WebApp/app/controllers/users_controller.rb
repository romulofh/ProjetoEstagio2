class UsersController < ApplicationController
  before_filter :authorize_user, only: [ :new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_login_path, notice: "Usuário cadastrado com sucesso"
    else
      render action: "new"
    end
  end

  private

  def authorize_user
    if current_user
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation, :admin)
  end
end
