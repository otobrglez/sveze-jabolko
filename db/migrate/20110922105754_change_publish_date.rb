class ChangePublishDate < ActiveRecord::Migration
  def self.up
    
    change_table :articles do |t|
      t.change :publish_date, :datetime
    end
    
  end
end
