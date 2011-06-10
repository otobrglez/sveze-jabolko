class RemoveSkypeNameFromArticle < ActiveRecord::Migration
  def up
    remove_column :articles, :skype_name
    Article.reset_column_information
  end

  def down
    add_column :articles, :skype_name, :string
  end
end
