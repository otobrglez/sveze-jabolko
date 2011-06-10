class RemoveSkypeNameFromArticle < ActiveRecord::Migration
  def up
    remove_column :users, :skype_name
  end

  def down
    add_column :users, :skype_name, :string
  end
end
