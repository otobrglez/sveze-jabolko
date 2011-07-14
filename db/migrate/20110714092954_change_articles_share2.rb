class ChangeArticlesShare2 < ActiveRecord::Migration
  def change
    add_column :articles, :recommend_visible, :integer, :default => 1
    remove_column :articles, :social_visible
  end
end
