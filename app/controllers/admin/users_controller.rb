class Admin::UsersController < AdminController
  
  inherit_resources
  actions :all, :except => [:index]
  defaults :route_prefix => 'admin'
  
  before_filter :find_user, :only => [:edit, :show, :update, :destroy]
  
  def index
    role = nil
    role = {:is_admin => 1} if params[:role] == "admin"
    role = {:is_author => 1} if params[:role] == "author"
    role = {:is_developer => 1} if params[:role] == "developer"
    
    @users = User.page(params[:users_page]).where(role).per(10)
    respond_with(@users)
  end
  
  def create
    create!(:notice => "User created!"){ admin_users_url() }
  end
  
  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    
    update! do |success, failure|
      success.html {
        flash[:notice] = "Uporabnik posodobljen."
        redirect_to admin_users_url()
      }
      failure.html {
        flash[:error] = "Napaka pri posodobitvi!"
        render :action => :edit
      }
    end
  end  
  
  private
    def find_user
      @user = User.find_by_id(params[:id])
      @user = User.find(params[:id]) if @category == nil
    end
  
end