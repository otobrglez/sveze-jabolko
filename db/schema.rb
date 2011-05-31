# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110531084235) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "image"
    t.text     "intro"
    t.text     "body"
    t.boolean  "published",   :default => false
    t.integer  "category_id"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles_sources", :id => false, :force => true do |t|
    t.integer "source_id"
    t.integer "article_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "is_admin",                              :default => false
    t.boolean  "is_author",                             :default => false
    t.boolean  "is_developer",                          :default => false
    t.string   "twitter_name"
    t.string   "facebook_name"
    t.string   "github_name"
    t.string   "skype_name"
    t.string   "home_url"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["facebook_name"], :name => "index_users_on_facebook_name", :unique => true
  add_index "users", ["github_name"], :name => "index_users_on_github_name", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["skype_name"], :name => "index_users_on_skype_name", :unique => true
  add_index "users", ["twitter_name"], :name => "index_users_on_twitter_name", :unique => true

end
