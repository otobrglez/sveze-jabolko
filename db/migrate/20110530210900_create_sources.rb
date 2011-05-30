class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :title
      t.string :url
      t.timestamps
    end
    
    create_table :articles_sources, :id => false do |t|
      t.references :source
      t.references :article
    end
  end
end
