class Project < ApplicationRecord
  enum :priority_level, { low: 0, medium: 1, high: 2 }
  enum :status, { pending: "pending", completed: "completed" }, prefix: true

  belongs_to :employee, class_name: "User", foreign_key: "user_id", optional: true

      scope :by_employee,   ->(id)    { id.present? ? where(user_id: id) : all }
      scope :by_priority,   ->(level) { level.present? ? where(priority_level: level) : all }
      scope :by_status,     ->(status){ status.present? ? where(status: status) : all }
      scope :by_due_date,   ->(date)  { date.present? ? where("due_date <= ?", date) : all }
      scope :by_category,   ->(cat)   { cat.present? ? where("category LIKE ?", "%#{sanitize_sql_like(cat)}%") : all }
      scope :created_from,  ->(date)  { date.present? ? where("projects.created_at >= ?", date) : all }
      scope :created_to,    ->(date)  { date.present? ? where("projects.created_at <= ?", date) : all }


  scope :title_contains, ->(keyword) { where("title LIKE ?", "%#{sanitize_sql_like(keyword)}%") if keyword.present? }
  scope :description_contains, ->(keyword) { where("description LIKE ?", "%#{sanitize_sql_like(keyword)}%") if keyword.present? }
  scope :employee_name_contains, ->(keyword) {
    joins(:employee).where("users.name LIKE ?", "%#{sanitize_sql_like(keyword)}%") if keyword.present?
  }

  def self.filter(params)
    Project.all
      .by_employee(params[:user_id])
      .by_status(params[:status])
      .by_priority(params[:priority])
      .by_due_date(params[:due_date])
      .by_category(params[:category])
      .created_from(params[:created_from])
      .created_to(params[:created_to])
  end


  def self.search(params)
    projects = Project.all
    if params["search"].present?
      keyword = "%#{sanitize_sql_like(params["search"])}%"

      adapter = ActiveRecord::Base.connection.adapter_name.downcase.to_sym
      operator = adapter == :postgresql ? "ILIKE" : "LIKE"

      projects = projects.left_joins(:employee).where(
        "projects.title #{operator} :kw OR projects.description #{operator} :kw OR users.name #{operator} :kw",
        kw: keyword
      )
    end
    projects
  end
end
