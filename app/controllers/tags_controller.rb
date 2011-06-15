class TagsController < ApplicationController
  
  respond_to :html
  
  def show
    @articles = Article.tagged_with(params[:tag_id]).page(params[:page]).per(10)
    return redirect_to "/404", :layout => false if @articles == nil
    
    respond_with(@articles)
  end
  
end