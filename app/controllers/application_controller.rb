class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_cdn
  before_filter :temp_move
  
  def set_cdn
    @gzp = env["HTTP_ACCEPT_ENCODING"]
  end
  
  def temp_move
    if not ['www.jabolko.org','localhost','stage-jabolko.heroku.com'].include?(request.host)
      redirect_to "http://www.jabolko.org/"
    end
    #unless ['sveze-jabolko.heroku.com','localhost'].include?(request.host)
    #  redirect_to "http://www.jabolko.org/off.html"
    #end
  end
  
  def missing_page
    render '404', :layout => "404"
  end
end
