class Admin::CategoriesController < AdminController
  
  inherit_resources
  actions :all, :except => [ :index ]
  defaults :route_prefix => 'admin'
  
  before_filter :get_category, :only => [:edit, :show, :update, :destroy]
  

  def index
    @categories = Category.page(params[:categories_page]).per(10)
    respond_with(@categories)
  end
  
  def create
    create!(:notice => "Category created!"){ admin_categories_url() }
  end
  
  def update
    update! do |success, failure|
      success.html { redirect_to admin_categories_url() }
    end
  end
  
  private
    def get_category
      @category = Category.find_by_slug(params[:id])
      @category = Category.find(params[:id]) if @category == nil
    end
  
  
end