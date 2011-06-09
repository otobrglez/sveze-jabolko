class AddRecommendedToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :views, :integer, :default => 0
    add_column :articles, :recommended, :integer, :default => 0
  end
end
