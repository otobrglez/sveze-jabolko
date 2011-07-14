class ArticlesController < ApplicationController
  
  respond_to :html
  respond_to :rss, :only => [:feed]
  
  def index
    @articles = Article.published.page(params[:page])
    respond_with(@articles)
  end
  
  def feed
    @articles = Article.published.limit(20)
    respond_with(@articles) do |f|
      f.rss { render :layout => false }
    end
  end
  
  def search
    @articles = Article.search(params[:query]).page(params[:page])
  end
  
  def show
    @article = Article.find_by_slug(params[:id])
    @article = Article.find(params[:id]) if @article == nil
    
    # Save view
    @article.views = @article.views+1
    @article.save
    
    return redirect_to "/404", :layout => false if @article == nil
    
    respond_with(@article)
  end
  
end
