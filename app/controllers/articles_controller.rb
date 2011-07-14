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
    if params[:query] != nil && params[:query] != "" && params[:query] != " "
      @articles = Article.search(params[:query]).page(params[:page])
    else
      @articles = []
    end
  end
  
  def show
    @article = nil
    begin
      @article = Article.find_by_slug(params[:id])
      @article = Article.find(params[:id]) if @article == nil
    rescue
      return redirect_to "/404", :layout => false
    end
    
    # Save view
    @article.views = @article.views+1
    @article.save
    
    return redirect_to "/404", :layout => false if @article == nil
    
    respond_with(@article)
  end
  
end
