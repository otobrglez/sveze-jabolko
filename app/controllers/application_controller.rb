class ApplicationController < ActionController::Base
  protect_from_forgery

  def missing_page
    render '404', :layout => "404"
  end
end
