class Admin::UsersController < AdminController
  
  def index
    @users = User.page(params[:users_page]).per(10)
    respond_with(@users)
  end
  
end