module ArticlesHelper
  
  include ActsAsTaggableOn::TagsHelper
  
  def article_created(article,options={},&block)
    authors = (article.authors.map { |author| link_to(author,author_path(author)) }.join(", ")).strip
    date = article.publish_date.strftime(I18n.t("date.formats.default".to_sym))
    
    category = nil
    if article.category !=nil
      if article.category.hidden?
        category = article.category
      else
        category = link_to(article.category, category_path(article.category))
      end
      category = I18n.t(:in) +" #{category}"
    end
    
    tags = nil
    if article.tag_list.size != 0
      tags = article.tag_list.to_a.map do |t|
        link_to(t.downcase,tag_path(t)) 
      end.join(", ").strip
      tags = I18n.t(:with_tags) + " #{tags}"
    end
    
    return "#{authors}, #{date} #{category} #{tags}."
  end
  
end
