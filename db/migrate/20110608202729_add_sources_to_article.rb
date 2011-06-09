class AddSourcesToArticle < ActiveRecord::Migration
  def up
    drop_table :articles_sources
    
    add_column :sources, :article_id, :integer
  end
  
  def down
    create_table :articles_users, :id => false do |t|
      t.integer :article_id
      t.integer :author_id
    end
  
    remove_column :sources, :article_id
  end
end
