require 'spec_helper'

describe SidebarHelper do

  it "has most viewed articles" do
    articles = sidebar_top_articles(10)
    articles.should == nil
  end
  

end