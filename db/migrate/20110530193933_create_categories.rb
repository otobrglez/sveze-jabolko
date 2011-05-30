class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.timestamps
    end
    
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.string :image
      t.text :intro
      t.text :body
      t.boolean :published, :default => false
      t.references :category
    end
  end
end
