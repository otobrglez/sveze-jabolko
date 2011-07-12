require 'spec_helper'

describe User do
  
  before(:each) do
    @user = User.new
  end
  
  it "has some required fields" do 
    @user.should have(1).error_on(:name)
    
    @user.is_admin?.should == false
    @user.is_author?.should == false
    @user.is_developer?.should == false
  end
  
  it "has some social media stuff" do
    # Some profile pictures
    @user.should respond_to :twitter_name
    @user.should respond_to :facebook_name
    @user.should respond_to :github_name
    # @user.should respond_to :skype_name
    @user.should respond_to :home_url
    @user.should respond_to :linkedin_name
    
    # Url validation
    @user.should have(0).error_on(:home_url)
    @user.home_url = "http://jabolko.org"
    @user.should have(0).error_on(:home_url)
  end
  
  it "has many articles" do
    @user.should respond_to :articles
    @user.articles << Article.new(:title => "Demo 1")
    @user.articles << Article.new(:title => "Demo x2")
    @user.articles.size.should == 2
  end
  
  it "has some magic functions" do
    @user.name = "Oto Brglez"
    @user.to_param.should == "oto-brglez"
  end

end
