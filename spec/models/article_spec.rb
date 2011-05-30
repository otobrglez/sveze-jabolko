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

end