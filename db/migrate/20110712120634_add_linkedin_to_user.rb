class AddLinkedinToUser < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_name, :string
  end
end
