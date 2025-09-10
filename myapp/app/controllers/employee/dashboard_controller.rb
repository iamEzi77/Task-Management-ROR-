class Employee::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_employee

  def index
    @user_name = current_user.name
    @projects = Project.where(user_id: current_user.id)
    @projects = @projects.where(status: params[:status]) if params[:status].present?
    @projects = @projects.where(priority_level: params[:priority_level]) if params[:priority_level].present?
    if params[:due_date_from].present?
      @projects = @projects.where("due_date >= ?", params[:due_date_from])
    end
    if params[:due_date_to].present?
      @projects = @projects.where("due_date <= ?", params[:due_date_to])
    end
    @projects = @projects.where("category ILIKE ?", "%#{params[:category]}%") if params[:category].present?
  end

end
