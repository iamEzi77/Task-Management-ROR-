class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.where(role: 'employee')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) 
    if @user.save
      redirect_to admin_users_path, notice: "Employee created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end


  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "Employee updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "Employee deleted successfully."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :role, :password, :password_confirmation)
  end
end
