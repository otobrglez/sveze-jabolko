require "spec_helper"

describe Category do
  
  before(:each) do
    @category = Category.new
  end
  
  it "has some require fields" do
    @category.should have(1).error_on(:title)
  end
  
  it "has many articles" do
    @category.should respond_to :articles
  end
  
  it "has some magic in slug" do
    @category.title = "Danes je lep dan"
    @category.to_param.should == "danes-je-lep-dan"
    @category.slug = "xxxx"
    @category.to_param.should == "xxxx"
  end
  
 
end