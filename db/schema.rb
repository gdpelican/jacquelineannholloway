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

ActiveRecord::Schema.define(:version => 20131124181243) do

  create_table "backgrounds", :force => true do |t|
    t.string   "slide_title"
    t.string   "picture_alt"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "blurb"
  end

  create_table "events", :force => true do |t|
    t.integer  "production_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.datetime "event_date"
    t.integer  "venue_id"
  end

  create_table "intro_blurbs", :force => true do |t|
    t.text     "text"
    t.integer  "order"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "salt"
    t.string   "pass_hash"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "productions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "duration"
    t.string   "blurb"
    t.string   "info_link"
    t.string   "ticket_link"
  end

  create_table "resume_items", :force => true do |t|
    t.string   "styles"
    t.string   "text"
    t.integer  "order"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "resume_line_id"
  end

  create_table "resume_lines", :force => true do |t|
    t.integer  "resume_section_id"
    t.string   "styles"
    t.integer  "order"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "resume_sections", :force => true do |t|
    t.integer  "resume_id"
    t.string   "styles"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "order"
  end

  create_table "resumes", :force => true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "site_configurations", :force => true do |t|
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "site_primary"
    t.string   "site_primary_rgb"
    t.string   "site_foreground"
    t.boolean  "current"
    t.integer  "upcoming_weeks"
  end

  create_table "socials", :force => true do |t|
    t.string   "name"
    t.string   "link"
    t.string   "js_function"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.string   "icon_name"
  end

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
