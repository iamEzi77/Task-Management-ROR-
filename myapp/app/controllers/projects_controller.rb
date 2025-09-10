class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin_or_employee

   def index
      # @projects = Project.filter(params).merge(Project.search(params))
      @projects = Project.all
      @employees = User.where(role: 0)
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
      
      if @project.save
        if current_user.admin?
          redirect_to projects_path, notice: "Project created successfully."
        else
          redirect_to projects_path, notice: "Project created successfully."
        end
      else
        @employees = User.where(role: 0) 
        render :new
      end
    end


    def edit
      @project = Project.find(params[:id])
      @employees = User.where(role: 0)
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
        redirect_to projects_path, notice: "Project deleted successfully."
      end
    end


    private

    def project_params
      params.require(:project).permit(:title, :description, :due_date, :priority_level, :category, :status, :user_id)
    end
end