class AddShortToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :short_url, :string
  end
end
