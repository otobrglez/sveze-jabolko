class FixArticleAuthor < ActiveRecord::Migration
  def up 
    remove_column :articles, :author_id
    
    create_table :articles_users, :id => false do |t|
      t.integer :article_id
      t.integer :author_id
    end
    
  end

  def down
    add_column :articles, :author_id, :integer
    drop_table :articles_users
  end
end
