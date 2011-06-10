class AuthorsController < ApplicationController
  
  respond_to :html
  
  def show
    @author = User.where(:is_admin => 1)
      .limit(1)
      .find_by_id(params[:user_id])

    return redirect_to "/404", :layout => false if @author == nil
    
    @articles = @author.articles.page(params[:page]).per(10)
  end
  
end
