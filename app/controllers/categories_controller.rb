class CategoriesController < ApplicationController
  
  respond_to :html

  def show
    @category = Category.find_by_slug(params[:category_id])
    
    if @category == nil # Try to
      @category = Category.find_by_id(params[:category_id])
    end
    
    return redirect_to "/404", :layout => false if @category == nil    
    return redirect_to(root_url) if @category.hidden?
    
    @articles = Article.published.where(:category_id => @category).page(params[:page]).per(7)
    respond_with(@category)
  end


end
