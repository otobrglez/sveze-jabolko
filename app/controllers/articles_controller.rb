class ArticlesController < ApplicationController
  
  respond_to :html
  
  def index
    @articles = Article.published.page(params[:page])
    respond_with(@articles)
  end
  
  def show
    @article = Article.find_by_slug(params[:id])
    @article = Article.find(params[:id]) if @article == nil
    
    return redirect_to "/404", :layout => false if @article == nil
    
    respond_with(@article)
  end
  
end
