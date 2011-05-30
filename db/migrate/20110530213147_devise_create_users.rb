class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
      
      t.string :name
      t.boolean :is_admin, :default => false
      t.boolean :is_author, :default => false
      t.boolean :is_developer, :default => false
      
      t.string :twitter_name
      t.string :facebook_name
      t.string :github_name
      t.string :skype_name
      
      t.string :home_url
    end

    add_index :users, :twitter_name,          :unique => true
    add_index :users, :facebook_name,         :unique => true
    add_index :users, :github_name,           :unique => true
    add_index :users, :skype_name,            :unique => true
    add_index :users, :name,                  :unique => true
    add_index :users, :email,                 :unique => true
    add_index :users, :reset_password_token,  :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
