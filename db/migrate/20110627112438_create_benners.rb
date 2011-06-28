class CreateBenners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      
      t.string :image_url
      t.string :link
      t.string :title
      t.string :position
      
      t.integer :number_of_clicks, :default => 0
      t.integer :hidden, :default => 0
      
      t.date :from_date
      t.date :to_date
      
      t.integer :width, :default => 256
      t.integer :height, :default => 148
      
      t.timestamps
      
    end
  end
end
