class TagsController < ApplicationController
  
  respond_to :html
  
  def show
    @articles = Article.tagged_with(params[:tag_id]).page(params[:page]).per(10)
    return redirect_to "/404", :layout => false if @articles == nil
    
    respond_with(@articles)
  end
  
  def index
    @tags = Article.tag_counts_on(:tags).to_a
    @letters = @tags.map {|t| t.name.upcase[0] }.sort.uniq

    # debugger

    t = 2
  end
  
end