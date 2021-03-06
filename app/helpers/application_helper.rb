module ApplicationHelper
  
  def page_title(title = nil)
    if title
      content_for(:page_title) { "#{title} - Jabolko.org" }
      return title
    else
      content_for?(:page_title) ? content_for(:page_title) : "Jabolko.org"
    end
  end
  
  def location()
    { :class => "#{controller_name}-#{action_name}", :id => "#{controller_name}"}
  end
  
end
