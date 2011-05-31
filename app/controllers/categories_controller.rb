class CategoriesController < ApplicationController
  
  respond_to :html
  
  def index
    @categories = Category.all
    respond_with(@categories)
  end
  
  def show
    
    @category = Category.find_by_slug(params[:category_id])
    
    if @category == nil # Try to
      @category = Category.find_by_id(params[:category_id])
    end
    
    return redirect_to "/404", :layout => false if @category == nil
    
    respond_with(@category)
  end


end
