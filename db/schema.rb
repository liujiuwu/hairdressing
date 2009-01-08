# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080823070001) do

  create_table "areas", :force => true do |t|
    t.string "code"
    t.string "name"
  end

  create_table "businesses", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "business_type"
    t.integer  "hits",          :limit => 11, :default => 0
    t.integer  "salon_id",      :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id",   :limit => 11, :default => 0,  :null => false
    t.string   "commentable_type", :limit => 15, :default => "", :null => false
    t.integer  "user_id",          :limit => 11, :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flacks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "hits",        :limit => 11, :default => 0
    t.boolean  "enable"
    t.integer  "salon_id",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fwus", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "price"
    t.float    "preferential_price"
    t.string   "fwu_type"
    t.integer  "salon_id",           :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hairstyles", :force => true do |t|
    t.string   "title"
    t.string   "from"
    t.text     "content"
    t.integer  "hits",       :limit => 11, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "infos", :force => true do |t|
    t.string   "title"
    t.integer  "info_type",          :limit => 11
    t.text     "description"
    t.string   "name"
    t.string   "telephone"
    t.string   "mobile"
    t.string   "email"
    t.string   "address"
    t.string   "postcode"
    t.integer  "period_of_validity", :limit => 11
    t.string   "city"
    t.integer  "hits",               :limit => 11, :default => 0
    t.integer  "user_id",            :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "enable",                    :default => true
    t.integer  "hits",        :limit => 11, :default => 0
    t.integer  "salon_id",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meta_contents", :force => true do |t|
    t.string "meta_name"
    t.string "meta_type"
    t.string "meta_code"
    t.string "remark"
  end

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "hits",       :limit => 11, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salons", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "shop_front"
    t.string   "address"
    t.string   "city"
    t.integer  "hits",             :limit => 11, :default => 0
    t.integer  "user_id",          :limit => 11
    t.string   "telephone"
    t.string   "traffic"
    t.string   "business_hours"
    t.integer  "fwus_count",       :limit => 11, :default => 0
    t.integer  "flacks_count",     :limit => 11, :default => 0
    t.integer  "jobs_count",       :limit => 11, :default => 0
    t.integer  "businesses_count", :limit => 11, :default => 0
    t.string   "markermap"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sayings", :force => true do |t|
    t.string   "name"
    t.string   "contact"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id",        :limit => 11
    t.integer  "taggable_id",   :limit => 11
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "logo"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.boolean  "is_admin",                                :default => false
    t.string   "name"
    t.string   "user_type"
    t.string   "whereareyou"
    t.text     "intro"
    t.string   "qq"
    t.string   "msn"
    t.string   "telephone"
    t.datetime "last_login_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.boolean  "vote",                        :default => false
    t.datetime "created_at",                                     :null => false
    t.string   "voteable_type", :limit => 15, :default => "",    :null => false
    t.integer  "voteable_id",   :limit => 11, :default => 0,     :null => false
    t.integer  "user_id",       :limit => 11, :default => 0,     :null => false
  end

end
