module ProjectsHelper
  def status_badge(status)
    case status
    when "pending"
      content_tag(:span, status.titleize, class: "px-2 py-1 text-xs font-semibold rounded-full bg-yellow-100 text-yellow-800")
    when "in_progress"
      content_tag(:span, "In Progress", class: "px-2 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-800")
    when "completed"
      content_tag(:span, status.titleize, class: "px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800")
    when "overdue"
      content_tag(:span, status.titleize, class: "px-2 py-1 text-xs font-semibold rounded-full bg-red-100 text-red-800")
    else
      content_tag(:span, status.titleize, class: "px-2 py-1 text-xs font-semibold rounded-full bg-gray-100 text-gray-800")
    end
  end

  def priority_badge(priority)
    case priority
    when "low"
      content_tag(:span, priority.titleize, class: "px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800")
    when "medium"
      content_tag(:span, priority.titleize, class: "px-2 py-1 text-xs font-semibold rounded-full bg-yellow-100 text-yellow-800")
    when "high"
      content_tag(:span, priority.titleize, class: "px-2 py-1 text-xs font-semibold rounded-full bg-orange-100 text-orange-800")
    when "critical"
      content_tag(:span, priority.titleize, class: "px-2 py-1 text-xs font-semibold rounded-full bg-red-100 text-red-800")
    else
      content_tag(:span, priority.titleize, class: "px-2 py-1 text-xs font-semibold rounded-full bg-gray-100 text-gray-800")
    end
  end
end
