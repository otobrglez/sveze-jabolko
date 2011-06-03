class ArtcileCommentsCount < ActiveRecord::Migration
  def up
    add_column :articles, :comments_count, :integer, :default => 0
  end

  def down
    remove_column :articles, :comments_count
  end
end
