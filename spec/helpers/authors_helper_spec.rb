require 'spec_helper'

describe AuthorsHelper do
  
  before(:each) do
    @author = User.new
    @author.name = "Oto Brglez"
    @author.email = "otobrglez@gmail.com"
    @author.is_author = 1
  end
  
  it "should be nil if author is nil" do
    author_links(nil).should == nil
  end
  
  it "has method authors_links" do
    @author.home_url = "http://opalab.com"
    author_links(@author).should match "http://opalab.com"
    
    @author.twitter_name = "otobrglez"
    author_links(@author).should match "twitter"
    
    @author.facebook_name = "oto.brglez"
    author_links(@author).should match "http://opalab.com"
    
    @author.github_name = "otobrglez"
    author_links(@author).should match "github"
    author_links(@author).should match "otobrglez"
    
    @author.should respond_to(:author_links_html)
    @author.author_links_html.should == author_links(@author)

    author_links(@author).should match "writer_links_seperator"
  end

end