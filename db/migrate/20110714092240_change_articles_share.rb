class ChangeArticlesShare < ActiveRecord::Migration
  def change
    add_column :articles, :share_visible, :integer, :default => 1
    add_column :articles, :social_visible, :integer, :default => 1
  end
end
