module DisqusHelper
  
  def disqus_thread(article)
    render :partial => 'layouts/disqus_thread', :locals => {:article => article}
  end
  
end
