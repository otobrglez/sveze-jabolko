module DisqusHelper
  
  def disqus_thread(article)
    render :partial => 'layouts/disqus_thread', :locals => {:article => article}
  end
  
  def disqus_posts(limit=7)
    require "net/http"
    
    url = "http://disqus.com/api/3.0/posts/list.json?limit=#{limit}&related=thread&api_secret=#{DISQUS['api_secret']}"
    
    begin
      logger.info "Fetching: disqus_posts - Started."
      posts = JSON.parse(Net::HTTP.get_response(URI.parse(url)).body)
      posts = posts["response"]
    rescue => e
      logger.info "Fetching: disqus_posts - Failed!"
      posts = []
    end
    
    posts
  end
  
end
