require 'spec_helper'

describe CategoriesController do

  describe "GET index" do
    it "should be successful" do
      get "index"
      response.should be_success
    end
  end

  describe "GET show" do
    it "should be redirect if it does not exist" do
      get :show, :category_id => "99999"
      response.should redirect_to("/404")
    end
  end
  
end
