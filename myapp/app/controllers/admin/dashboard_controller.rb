class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_employee, only: [:report_generator]
  def  index
    @user_name = current_user.name
  end

 def all_employees
      @employees = User.where(role: "employee") 
    end
    def report_generator
       projects = Project.where(user_id: @employee.id)

      @report = {
        total_projects: projects.count,
        completed_projects: projects.where(status: "completed").count,
        pending_projects: projects.where(status: "pending").count,
        overdue_projects: projects.where("due_date < ? AND status != ?", Date.today, "completed").count
      }
    end

     private

    def set_employee
      @employee = User.find(params[:id])
    end
end
