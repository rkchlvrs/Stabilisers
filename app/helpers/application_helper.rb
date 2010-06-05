# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # return a title on a per-page basis
  def title
    base_title = "Stabilisers"
    if @title.nil?
      base_title
    else
      # the h before (@title) is short for html_escape
      # it protects against script attacks
      # might not be necessary with a) Rails 3.0 and b) haml :escape-html option
      "#{base_title} - #{h(@title)}"
    end
  end
  
end
