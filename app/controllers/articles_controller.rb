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
      f.html { redirect_to root_url }
    end
  end
  
  def search
    @service_error = false
    if params[:query] != nil && params[:query] != "" && params[:query] != " "
      begin
        @articles = Article.search(params[:query])
        @articles = Kaminari.paginate_array(@articles).page(params[:articles_page]).per(7)
      rescue Exception => e
        @articles = []
        @service_error = true
      end
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
  
  def steve_jobs
    respond_to do |f|
      f.html { render "special_intro", :layout => false }
    end
  end
  
end
