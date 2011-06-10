class AddAboutToUser < ActiveRecord::Migration
  def change
    add_column :users, :about, :text
    User.reset_column_information
  end
end
