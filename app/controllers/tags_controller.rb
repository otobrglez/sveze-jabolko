class TagsController < ApplicationController
  
  respond_to :html
  
  def show
    @articles = Article.tagged_with(params[:tag_id]).page(params[:page]).per(10)
    return redirect_to "/404", :layout => false if @articles == nil
    
    #@articles = Article.published.where(:category_id => @category).page(params[:page]).per(5)
    respond_with(@articles)
  end
  
end