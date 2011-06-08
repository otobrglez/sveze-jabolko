require 'spec_helper'

describe ArticlesHelper do

  before(:each) do
    @article = Article.new
    @article.created_at = DateTime.now
    @user = User.new
  end
  
  it "supports one author" do
    @article.title = "Danes je lep dan"
    @user.name = "Oto Brglez"
    @article.authors << @user
    
    article_created(@article).should match "Oto Brglez"
  end
  
  it "supports two or more authors" do
    @article.title = "Danes je lep dan II"
    @user_a = User.new
    @user_a.name = "Oto Brglez"
    
    @user_b = User.new
    @user_b.name = "Janez Klobasica"
    
    @article.authors << [@user_a, @user_b]
    
    article_created(@article).should match "Oto Brglez"
    article_created(@article).should match "Janez Klobasica"
  end
  
  it "supports nice date format" do
    @user = User.new
    @user.name = "Oto Brglez"
    @article.authors << @user
    
    @article.created_at = DateTime.now
    
    article_created(@article).should match DateTime.now.strftime(I18n.t("date.formats.default".to_sym))
  end
  
  it "has some tags" do
    @user = User.new
    @user.name = "Oto Brglez"
    @article.authors << @user
    
    @article.tag_list = "test1, test2, xxx"
    
    article_created(@article).should match "test1"
    article_created(@article).should match "test2"
    article_created(@article).should match "xxx"
  end
  
  it "supports some categories" do
    @user = User.new
    @user.name = "Oto Brglez"
    @article.authors << @user
    
    @article.category = Category.new :title => "novice"
    article_created(@article).should match "novice"   
  end
  
end
