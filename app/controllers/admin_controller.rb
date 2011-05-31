class AdminController < ApplicationController  
  before_filter :authenticate_user!
  respond_to :html

  def dash
      
    respond_with  do |f|
      f.html{ render "dash"}
    end
  end

end
