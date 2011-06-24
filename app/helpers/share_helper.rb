module ShareHelper
  
  def share_article(article)
    render :partial => 'articles/share_article', :locals => {:article => article}
  end
  
end
