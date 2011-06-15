class Admin::ArticlesController < AdminController
  
  respond_to :html
  
  before_filter :find_article, :only => [:edit, :update, :destroy]
  
  def index
    if params[:category_id] != nil
      @articles = Article.where(:category_id => params[:category_id]).page(params[:articles_page]).per(30)
    else
      @articles = Article.page(params[:articles_page]).per(30)
    end
    @categories = Category.all
    
    respond_with(@articles)
  end
  
  def edit
    @article.sources << Source.new if @article.sources.size == 0
    respond_with(@article)
  end
  
  def new
    @article = Article.new
    @article.authors << current_user
    @article.sources << Source.new if @article.new_record?
    respond_with(@article)
  end

  def update
    @article ||= Article.find(params[:id])
    params[:article][:slug] = nil if params[:article][:slug] == ""
    params[:article][:author_ids] ||= []
    # params[:article][:tag_list] = params[:article][:tag_list].downcase
    
    @article.update_attributes(params[:article])
    
    respond_to do |format|
      if @article.save
        flash[:notice] = I18n.t("flash.actions.#{action_name}.notice")
        format.html { redirect_to article_path(@article.category,@article) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def create
    @article = Article.new(params[:article])
    respond_to do |format|
      if @article.save
        flash[:notice] = I18n.t("flash.actions.#{action_name}.notice")
        format.html { redirect_to article_path(@article.category,@article) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def destroy
    if @article.destroy
      flash[:notice] = "Article destroyed!"
    end
    
    respond_with(@destroy) do |f|
      f.html { redirect_to :action => :index }
    end
  end
  
  private
    def find_article
      @article = Article.find_by_slug(params[:id])
      @article = Article.find(params[:id]) if @article == nil
    end

end