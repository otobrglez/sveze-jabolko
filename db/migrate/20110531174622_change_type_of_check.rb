class ChangeTypeOfCheck < ActiveRecord::Migration
  def up
    remove_column :articles, :published
    add_column :articles, :published, :integer, :default => 0
    
  end

  def down
    remove_column :articles, :published
    add_column :articles, :published, :boolean, :default => false 
  end
end
