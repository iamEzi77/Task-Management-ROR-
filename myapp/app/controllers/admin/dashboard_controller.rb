class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  def  index
    @user_name = current_user.name
  end
end
