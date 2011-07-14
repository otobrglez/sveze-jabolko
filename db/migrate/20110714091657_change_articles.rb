class ChangeArticles < ActiveRecord::Migration
  
  
  def change
    add_column :articles, :comments_visible, :integer, :default => 1
    add_column :articles, :image_visible, :integer, :default => 1
  end
end
