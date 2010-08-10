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

ActiveRecord::Schema.define(:version => 20100714182013) do

  create_table "administrators", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_id"
    t.boolean  "active",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "announcements", :force => true do |t|
    t.text     "contents"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.datetime "starting_at"
    t.datetime "ending_at"
    t.integer  "num_volunteers_needed"
    t.string   "event_name"
    t.string   "location"
    t.boolean  "active",                :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guardians", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "household_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_primary"
    t.integer  "relationship"
    t.boolean  "is_female"
    t.integer  "ethnicity"
    t.string   "mobile_phone"
    t.string   "work_phone"
    t.integer  "user_id"
    t.boolean  "security_form"
    t.boolean  "active",        :default => true
  end

  create_table "households", :force => true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state",              :default => "PA"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "zip"
    t.string   "home_phone"
    t.boolean  "free_lunch"
    t.integer  "status"
    t.boolean  "active",             :default => true
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "privacy_settings", :force => true do |t|
    t.integer  "household_id"
    t.boolean  "public_address",      :default => true
    t.boolean  "public_names",        :default => true
    t.boolean  "public_children",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public_emails",       :default => true
    t.boolean  "public_demographics", :default => true
    t.boolean  "public_home_phone",   :default => true
    t.boolean  "public_other_phones", :default => true
  end

  create_table "signups", :force => true do |t|
    t.integer  "guardian_id"
    t.integer  "event_id"
    t.boolean  "attended"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "household_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grade"
    t.date     "dob"
    t.integer  "ethnicity"
    t.boolean  "is_female"
    t.integer  "engrade_id"
    t.boolean  "active",       :default => true
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "persistence_token"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",              :default => "guardian"
    t.string   "temp_pswd"
    t.boolean  "active",            :default => true
  end

end
