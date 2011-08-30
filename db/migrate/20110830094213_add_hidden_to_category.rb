class AddHiddenToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :hidden, :integer, :default => 0
  end
end
