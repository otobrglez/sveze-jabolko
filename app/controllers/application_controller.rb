class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_cdn
  before_filter :temp_move
  before_filter :authenticate_user!, :if => :detect_stage
  
  def set_cdn
    @gzp = env["HTTP_ACCEPT_ENCODING"]
  end
  
  def temp_move
    if not ['www.jabolko.org','localhost','stage-jabolko.heroku.com'].include?(request.host)
      redirect_to "http://www.jabolko.org/"
    end
  end
  
  def detect_stage
    ['stage-jabolko.heroku.com'].include?(request.host)
  end
  
  def missing_page
    render '404', :layout => "404"
  end
end
