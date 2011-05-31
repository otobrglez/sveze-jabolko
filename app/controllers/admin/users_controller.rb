class Admin::UsersController < AdminController
  
  inherit_resources
  actions :all, :except => [:index]
  defaults :route_prefix => 'admin'
  
  before_filter :find_user, :only => [:edit, :show, :update, :destroy]
  
  def index
    @users = User.page(params[:users_page]).per(10)
    respond_with(@users)
  end
  
  def create
    create!(:notice => "User created!"){ admin_users_url() }
  end
  
  def update
    update! do |success, failure|
      success.html { redirect_to admin_users_url() }
      failure.html { render :action => :edit}
    end
  end  
  
  private
    def find_user
      @user = User.find_by_id(params[:id])
      @user = User.find(params[:id]) if @category == nil
    end
  
end