class AuthorsController < ApplicationController
  
  respond_to :html
  
  def show
    @author = User.authors
      .limit(1)
      .find_by_id(params[:user_id])

    return redirect_to "/404", :layout => false if @author == nil
    
    @articles = @author.articles.page(params[:page]).per(20)
  end
  
  def index
    @authors = User.authors_with_numbers.page(params[:page]).per(20)
  end
  
end
