class RemoveSkypeNameFromArticle < ActiveRecord::Migration
  def up
    remove_column :users, :skype_name
    Users.reset_column_information
  end

  def down
    add_column :users, :skype_name, :string
  end
end
