class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         enum :role, { employee: 0, admin: 1 }

  has_many :projects

  def admin?
    role == 'admin'
  end

  def employee?
    role == 'employee'
  end


  def performance_report
    {
      total_projects: projects.count,
      completed_projects: projects.where(status: "completed").count,
      pending_projects: projects.where.not(status: "completed").count,
      overdue_projects: projects.where("due_date < ? AND status != ?", Date.today, "completed").count
    }
  end
   
end
