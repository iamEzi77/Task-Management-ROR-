module ApplicationHelper
def toggle_direction(column)
  if params[:sort_by] == column
    params[:direction] == "asc" ? "desc" : "asc"
  else
    "asc"
  end
end

  def field_errors(resource, field)
    return "" unless resource&.errors[field].any?

    resource.errors[field].map do |msg|
      content_tag(:p, msg, class: "text-red-600 text-sm mt-1")
    end.join.html_safe
  end
end
