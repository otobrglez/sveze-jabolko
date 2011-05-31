class Admin::ArticlesController < AdminController
  
  respond_to :html
  
  before_filter :find_article, :only => [:edit, :update]
  
  def find_article
    @article = Article.find_by_slug(params[:id])
    @article = Article.find(params[:id]) if @article == nil
  end
  
  def index
    @articles = Article.page(params[:articles_page]).per(30)
    respond_with(@articles)
  end
  
  def edit
    respond_with(@article)
  end
  
  def new
    @article = Article.new
    respond_with(@article)
  end

  def update
    @article ||= Article.find(params[:id])
    @article.update_attributes(params[:article])
    
    if params[:article][:slug] == ""
      @article.slug = nil 
      @article.save
      flash[:notice] = "Article \"#{@article}\" was updated."
      return redirect_to :action => "index"
    end
    
    flash[:notice_item] = "Article updated" 
    respond_with(@article) do |f|
      f.html { render :action => :edit }
    end
  end
  
  def create
    @article = Article.new(params[:article])
    if @article.valid?
      @article.save
      flash[:notice] = "Article stored."
    end
    
    respond_with(@article) do |f|
      f.html {
        if @article.published? && @article.valid?
          redirect_to article_url(article.category,article)
        elsif not @article.published? && @article.valid?
          redirect_to admin_articles_url()
        else
          render :action => :edit
        end
      }
    end
  end

end