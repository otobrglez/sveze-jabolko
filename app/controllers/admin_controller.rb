class AdminController < ApplicationController  
  before_filter :authenticate_user!
  before_filter :is_administration
  respond_to :html

  def dash
      
    respond_with  do |f|
      f.html{ render "dash"}
    end
  end

  private
    def is_administration
      if current_user.is_admin
        @is_administration = 1
      end
    end

end
