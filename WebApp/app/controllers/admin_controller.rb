class AdminController < ApplicationController

  def new
    @admin = User.new
  end

  def create
    @admin = User.new(admin_params)
    @admin.admin = true
    if @admin.save
      redirect_to admin_login_path, notice: "Administrador cadastrado com sucesso"
    else
      render action: "new"
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :email, :password,:password_confirmation, :admin)
  end
end
