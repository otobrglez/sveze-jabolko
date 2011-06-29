require 'spec_helper'

describe DisqusHelper do
  
  describe "Comments" do
    it "has some functions" do
    
      @category = Category.new :title => "Kategorija"
      @article = Article.new :title => "Tole je naslov"
      @article.category = @category
      
      @article.slug = "330-ipad-2-smart-cover-evernote-peek-in-ucenje"

      disqus_thread(@article).should match "disqus_identifier"      
      disqus_thread(@article).should match "disqus_url"
      disqus_thread(@article).should match "disqus_url"
      disqus_thread(@article).should match  (@article.slug).to_s      
    end
    
    it "has posts" do
      disqus_posts.should_not == nil
      posts = disqus_posts(7)
      posts.size.should == 7
      
      posts = disqus_posts(3)
      posts.size.should == 3
      
      post = posts.first
      post["thread"]["link"].should_not == nil
      post["thread"]["title"].should_not == nil
      
    end
  end
end
