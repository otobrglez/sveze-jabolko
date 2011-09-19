class Admin::TagsController < AdminController
  
  inherit_resources
  actions :all, :except => [:index]
  defaults :route_prefix => 'admin'
  respond_to :html, :json
  
  def index
    @tags = Article.tag_counts_on(:tags, :order => "name ASC")
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

  def destroy
    @tag ||= ActsAsTaggableOn::Tag.find(params[:id])
    return redirect_to [:admin,:tags] if @tag.nil?
    notice = "Tag odstranjen!" if @tag.destroy

    respond_with(@tag) do |f|
      f.html {  redirect_to [:admin,:tags] }
      f.js{ return render :destroy, :layout => false }
    end
   
  end

  def edit
    @tag ||= ActsAsTaggableOn::Tag.find(params[:id])
    respond_with(@tag) do |f|
      f.js { return render :edit, :layout => false}
    end
  end

  def update
    @tag ||= ActsAsTaggableOn::Tag.find(params[:id])
    @tag.update_attributes(params[:acts_as_taggable_on_tag])

    respond_with(@tag) do |f|
      f.js do
        if @tag.save
          return render :view, :layout => false
        else
          return render :edit, :layout => false
        end
      end
    end
  end
  
end