require 'spec_helper'

describe Source do

  before(:each) do 
    @source = Source.new
  end
  
  it "has some required fields" do
    @source.should have(1).error_on(:title)
    @source.should have(2).error_on(:url)
  end
  
  it "has many articles" do
    @source.should respond_to :articles
  end

  it "url format should be perfect" do
    @source.url = "demo"
    @source.should have(1).error_on(:url)
  
    @source.url = "http://demo"
    @source.should have(1).error_on(:url)
  
    @source.url = "http://www.demo.si"
    @source.should have(0).error_on(:url)
  end

end
