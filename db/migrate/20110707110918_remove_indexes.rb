class RemoveIndexes < ActiveRecord::Migration
  def up
    remove_index :users, :twitter_name    
    remove_index :users, :facebook_name     
    remove_index :users, :github_name      
    remove_index :users, :skype_name        
  end
end
