class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_cdn
  
  def set_cdn
    @gzp = env["HTTP_ACCEPT_ENCODING"]
  end
  
  def missing_page
    render '404', :layout => "404"
  end
end
