module SidebarHelper
  
  def sidebar_top_articles(limit=10)
    nil
  end
  
  def sidebar_forum_posts(limit=7)
    require "net/http"
    url = "http://forum.jabolko.org/izmenjava.php?a=posts"
    posts = JSON.parse(Net::HTTP.get_response(URI.parse(url)).body).slice(0,limit)
    posts
  end

end