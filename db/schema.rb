# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20110916110449) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "image"
    t.text     "intro"
    t.text     "body"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "published",         :default => 0
    t.integer  "comments_count",    :default => 0
    t.integer  "views",             :default => 0
    t.integer  "recommended",       :default => 0
    t.string   "short_url"
    t.integer  "comments_visible",  :default => 1
    t.integer  "image_visible",     :default => 1
    t.integer  "share_visible",     :default => 1
    t.integer  "recommend_visible", :default => 1
    t.integer  "hidden",            :default => 0
    t.date     "publish_date"
  end

  create_table "articles_users", :id => false, :force => true do |t|
    t.integer "article_id"
    t.integer "author_id"
  end

  create_table "banners", :force => true do |t|
    t.string   "image_url"
    t.string   "link"
    t.string   "title"
    t.string   "position"
    t.integer  "number_of_clicks", :default => 0
    t.integer  "hidden",           :default => 0
    t.date     "from_date"
    t.date     "to_date"
    t.integer  "width",            :default => 256
    t.integer  "height",           :default => 148
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hidden",      :default => 0
  end

  create_table "sources", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_id"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
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
    t.string   "twitter_name"
    t.string   "facebook_name"
    t.string   "github_name"
    t.string   "home_url"
    t.integer  "is_admin",                              :default => 0
    t.integer  "is_developer",                          :default => 0
    t.integer  "is_author",                             :default => 0
    t.text     "about"
    t.string   "linkedin_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
