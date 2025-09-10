class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.admin?
      redirect_to admin_dashboard_index_path
    else
      redirect_to employee_dashboard_index_path
    end
  end
end
