module ArticlesHelper
  
  include ActsAsTaggableOn::TagsHelper
  
  def article_created(article,options={},&block)
    authors = (article.authors.map { |author| link_to(author,author_path(author)) }.join(", ")).strip
    date = article.created_at.strftime(I18n.t("date.formats.default".to_sym))
    
    category = nil
    if article.category !=nil
      category = link_to(article.category, category_path(article.category))
      category = I18n.t(:in) +" #{category}"
    end
    
    tags = nil
    if article.tag_list.size != 0
      tags = article.tag_list.to_a.map { |t| link_to(t.downcase,tag_path(t)) }.join(", ").strip
      tags = I18n.t(:with_tags) + " #{tags}"
    end
    
    return "#{authors}, #{date} #{category} #{tags}."
  end
  
end
