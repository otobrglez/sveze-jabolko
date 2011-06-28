class Admin::BannersController < AdminController
  
  inherit_resources
  defaults :route_prefix => 'admin'
  
  def update
    update! do |success, failure|
      success.html { redirect_to admin_banners_url }
    end
  end
  
  def create
    create!(:notice => "Banner created!") { admin_banners_url }
  end
  
end
