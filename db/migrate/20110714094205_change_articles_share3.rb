class ChangeArticlesShare3 < ActiveRecord::Migration
  def change
    add_column :articles, :hidden, :integer, :default => 0
  end
end
