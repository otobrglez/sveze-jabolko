class ArticlesController < ApplicationController
  
  respond_to :html
  
  def index
    @articles = Article.all
    respond_with(@articles)
  end
  
  def show
    @article = Article.find_by_id(params[:id])
    
    return redirect_to "/404", :layout => false if @article == nil
    
    respond_with(@article)
  end
  
end
