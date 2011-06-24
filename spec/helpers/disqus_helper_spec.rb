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
      
      puts disqus_thread(@article).to_s

    
    end
  end
end
