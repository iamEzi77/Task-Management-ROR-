class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin_or_employee
    before_action :set_employee, only: [:index, :new, :create, :edit]

     helper ApplicationHelper
   def index
    if params[:search].present?
      @projects = Project.search(params)
    elsif params[:user_id].present? || params[:status].present? || params[:priority].present? ||
          params[:due_date].present? || params[:category].present? || params[:created_from].present? ||
          params[:created_to].present?
      @projects = Project.filter(params)
    else
      @projects = Project.all
    end
     @projects = apply_sort(@projects, params[:sort_by], params[:direction])
   end

    def show
      @project = Project.find(params[:id])
    end

    def new
      @project = Project.new
      @employees = User.where(role: 0)
    end
    def create
      @project = Project.new(project_params)
      @project.user = current_user unless current_user.admin?

      if @project.save
        redirect_to @project, notice: "Project created successfully."
      else
        render :new, status: :unprocessable_entity 
      end
    end


    def edit
      @project = Project.find(params[:id])
    end

    def update
      @project = Project.find(params[:id])
      
      if @project.update(project_params)
        if current_user.admin?
          redirect_to projects_path, notice: "Project updated successfully."
        else
          redirect_to projects_path, notice: "Project updated successfully."
        end
      else
        render :edit
      end
    end


    def destroy
      @project = Project.find(params[:id])
      @project.destroy

      if current_user.admin?
        redirect_to projects_path, notice: "Project deleted successfully."
      else
        redirect_to employee_dashboard_index_path, notice: "Project deleted successfully."
      end
    end



    private

    def project_params
      params.require(:project).permit(:title, :description, :due_date, :priority_level, :category, :status, :user_id)
    end

    def set_employee
      @employees = User.where(role: 0)
    end

    def apply_sort(projects, sort_by, direction)
      return projects unless sort_by.present?

      direction = %w[asc desc].include?(direction) ? direction : "asc"

      case sort_by
      when "due_date"
        projects.order(due_date: direction)
      when "priority"
        projects.order(priority_level: direction)
      when "created_at"
        projects.order(created_at: direction)
      when "title"
        projects.order(title: direction)
      else
        projects
      end
    end
end