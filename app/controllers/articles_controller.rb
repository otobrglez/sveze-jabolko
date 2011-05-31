class ArticlesController < ApplicationController
  
  respond_to :html
  
  def index
    
    @articles = Article.all
    
    respond_with(@articles)
  end
  
end
