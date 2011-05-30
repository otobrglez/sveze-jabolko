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
    @article.published.should == false
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

end