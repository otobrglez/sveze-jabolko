require "spec_helper"

describe Article do

  before(:each) do
    @article = Article.new
  end
  
  it "belongs to category" do
    @article.should have(1).error_on(:category)
    @article.should have(1).error_on(:title)
    @article.should have(1).error_on(:intro)
    @article.should have(1).error_on(:body)
    @article.should have(1).error_on(:author)
  end
  
  it "belongs to category" do
    @article.should respond_to :category
  end
  
  it "has magic method to_param" do
    @article.title = "Danes je lep dan"
    @article.to_param.should == "danes-je-lep-dan"
  end
  
  it "has slug whitch overrides to_param" do
    @article.title = "Danes je lep dan"
    @article.slug = "test dan"
    @article.to_param.should == "test dan"
  end
  
  it "by default articles are not published" do
    @article.published.should == 0 # 0 Published articles
    @article.published?.should == false
  end
  
  it "has many sources" do
    @article.should respond_to :sources
    
    @article.sources << Source.new( :title => "Demo title", :url => "http://apple.com")
    @article.sources << Source.new( :title => "Demo title 2", :url => "http://google.com")
    @article.sources.size.should == 2
  end

  it "has author" do
    @article.should respond_to :author
    @article.should have(1).error_on(:author)
    
    @article.author = User.new :name => "Oto Brglez"
    @article.should have(0).error_on(:author)
  end
  
  it "responds to tags" do
    @article.should respond_to :tags
    @article.should respond_to :tag_list
  end
  
  it "has some tags" do
    @article = Article.new
    @article.tag_list = "danes je lep dan dan"
    @article.tag_list.size.should == 1
    @article.tag_list = "danes, je, lep, dan dan"
    @article.tag_list.size.should == 4
  end
  
  it "has some Redcarpet support" do
    niz = "To je spletna stran \"Jabolko.org\":http://jabolko.org"
    
    #require "redcarpet"
    #test_b = Redcarpet.new(niz).to_html
    test_b = RedCloth.new(niz).to_html
    
    @article = Article.new
    @article.body = niz
    @article.body_html.should == test_b
  end
  
  it "body_html should also work on nil" do
    @article = Article.new
    @article.body_html.should == nil
  end
  
  it "intro_html should also work" do
    @article = Article.new
    @article.intro = "Demo"
    @article.intro_html.should == "<p>Demo</p>"
  end
  

  it "has jid" do
    @article = Article.new
    @article.jid.should == nil
    @article.id = 111
    @article.id.should == 111
    @article.should respond_to :jid
    @article.jid.should == "jid-111-test"
  end

end