class Admin::TagsController < AdminController
  
  inherit_resources
  actions :all, :except => [:index]
  defaults :route_prefix => 'admin'
  respond_to :html, :json, :js
  
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

  def upmerge
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @m_tag = ActsAsTaggableOn::Tag.find(params[:acts_as_taggable_on_tag][:m_tag])

    # Add m_tag to tag
    list_a = Article.tagged_with(@tag.name)
    list_a.each do |a|
      a.tag_list << @m_tag.name
      a.save
    end

    # Add tag to m_tag
    list_b = Article.tagged_with(@m_tag.name)
    list_b.each do |a|
      a.tag_list << @tag.name
      a.save
    end

    # Reload records
    @tag_count = Article.tagged_with(@tag).count
    @m_tag_count = Article.tagged_with(@m_tag).count

    # Destroy right sided m_tag!
    @m_tag.destroy

    respond_to do |f|
      f.js { return render :upmerge, :layout => false }
    end

  end

  def merge
    @tag ||= ActsAsTaggableOn::Tag.find(params[:id])
    @tags = Article.tag_counts_on(:tags, :order => "name ASC")

    respond_with(@tag) do |f|
      f.js { return render :merge, :layout => false}
    end
  end
  
end