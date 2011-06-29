class Admin::TagsController < AdminController
  
  inherit_resources
  actions :all, :except => [:index]
  defaults :route_prefix => 'admin'
  respond_to :html, :json
  
  def index
    @tags = Article.tag_counts_on(:tags)
  end
  
  def search #?term=ab
    term = ""
    term = params[:term].strip if params[:term].strip != ""
    
    @tags = Article.tag_counts_on(:tags).find_all {|t| t.name =~ Regexp.new(term,true) }
    
    respond_with(@tags) do |f|
      f.json {
        return render :json => @tags.map {|t|
          { id: t.name, label: t.name, value: t.name }
        }.to_json
      }
    end
  end
  
end