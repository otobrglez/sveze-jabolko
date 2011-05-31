class AddCreatedAtToArticle < ActiveRecord::Migration
  def self.up
    add_timestamps(:articles)
  end
  
  def self.down
    remove_timestamps(:articles)
  end
end
