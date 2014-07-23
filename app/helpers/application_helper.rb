module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, sort: column, direction: direction
  end

  # Set css class selector
  def is_active?(link_path)
    current_page?(link_path) ? "active" : ""
  end
end
