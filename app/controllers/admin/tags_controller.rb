class Admin::TagsController < AdminController
  
  inherit_resources
  actions :all, :except => [:index]
  defaults :route_prefix => 'admin'
  
  def index
    @tags = Article.tag_counts_on(:tags)
  end
  
end