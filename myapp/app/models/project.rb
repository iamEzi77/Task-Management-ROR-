class Project < ApplicationRecord
  enum :priority_level, { low: 0, medium: 1, high: 2 }
  enum :status, { pending: "pending", completed: "completed" , overdue: "overdue"}, prefix: true

  belongs_to :user 

  scope :by_employee,   ->(id)    { where(user_id: id) if id.present? }
  scope :by_priority,   ->(level) { where(priority_level: level) if level.present? }
  scope :by_status,     ->(status){ where(status: status) if status.present? }
  scope :by_due_date,   ->(date)  { where("due_date <= ?", date) if date.present? }
  scope :by_category,   ->(cat)   { where("category LIKE ?", "%#{sanitize_sql_like(cat)}%") if cat.present? }
  scope :created_from,  ->(date)  { where("projects.created_at >= ?", date) if date.present? }
  scope :created_to,    ->(date)  { where("projects.created_at <= ?", date) if date.present? }

  scope :title_contains,       ->(keyword) { where("title LIKE ?", "%#{sanitize_sql_like(keyword)}%") if keyword.present? }
  scope :description_contains, ->(keyword) { where("description LIKE ?", "%#{sanitize_sql_like(keyword)}%") if keyword.present? }
  scope :employee_name_contains, ->(keyword) {
    joins(:user).where("users.name LIKE ?", "%#{sanitize_sql_like(keyword)}%") if keyword.present?
  }

  def self.filter(params)
    projects = Project.all
    projects = projects.by_employee(params[:user_id])
    projects = projects.by_status(params[:status])
    projects = projects.by_priority(params[:priority])
    projects = projects.by_due_date(params[:due_date])
    projects = projects.by_category(params[:category])
    projects = projects.created_from(params[:created_from])
    projects = projects.created_to(params[:created_to])
    projects
  end

  def self.search(params)
    projects = Project.all

    if params[:kw].present?
      keyword = "%#{sanitize_sql_like(params[:kw])}%"
      adapter = ActiveRecord::Base.connection.adapter_name.downcase.to_sym
      operator = adapter == :postgresql ? "ILIKE" : "LIKE"

      projects = projects.left_joins(:user).where(
        "projects.title #{operator} :kw OR projects.description #{operator} :kw OR users.name #{operator} :kw",
        kw: keyword
      )
    end

    projects
  end


end
