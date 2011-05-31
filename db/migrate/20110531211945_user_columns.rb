class UserColumns < ActiveRecord::Migration
  def up
    remove_column :users, :is_admin
    remove_column :users, :is_developer
    remove_column :users, :is_author
    
    add_column :users, :is_admin, :integer, :default => 0
    add_column :users, :is_developer, :integer, :default => 0
    add_column :users, :is_author, :integer, :default => 0
    
  end

  def down
    remove_column :users, :is_admin
    remove_column :users, :is_developer
    remove_column :users, :is_author
    
    add_column :users, :published, :boolean, :default => false 
    add_column :users, :published, :boolean, :default => false 
    add_column :users, :published, :boolean, :default => false 
  end
end
