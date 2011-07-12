class Admin::BannersController < AdminController
  
  inherit_resources
  defaults :route_prefix => 'admin'
  
  def index
    if params[:position]!=nil
      @banners = Banner.where(:position => params[:position]) 
    else
      @banners = Banner.all
    end
  end
  
  def update
    update! do |success, failure|
      success.html { redirect_to admin_banners_url }
    end
  end
  
  def create
    create!(:notice => "Banner created!") { admin_banners_url }
  end
  
end
