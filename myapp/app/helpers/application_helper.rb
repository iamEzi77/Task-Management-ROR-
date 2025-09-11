module ApplicationHelper
def toggle_direction(column)
  if params[:sort_by] == column
    params[:direction] == "asc" ? "desc" : "asc"
  else
    "asc"
  end
end


end