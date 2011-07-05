class AdminController < ApplicationController  
  
  before_filter :authenticate_user!
  before_filter :is_administration
  respond_to :html
  layout 'administration'

  def dash
    respond_with  do |f|
      f.html{ redirect_to [:admin, :articles]}
    end
  end

  private
    def is_administration
      if user_signed_in? && current_user.is_admin
        @is_administration = 1
      end
    end

end
