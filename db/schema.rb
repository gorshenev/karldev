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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141203073440) do

  create_table "bootsy_image_galleries", force: true do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: true do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "location"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.text     "description"
    t.string   "title"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean  "all_day"
    t.string   "color"
    t.integer  "speciality_id"
    t.integer  "specialities_id"
  end

  add_index "events", ["all_day"], name: "index_events_on_all_day"
  add_index "events", ["color"], name: "index_events_on_color"
  add_index "events", ["creator_id"], name: "index_events_on_creator_id"
  add_index "events", ["ends_at"], name: "index_events_on_ends_at"
  add_index "events", ["location"], name: "index_events_on_location"
  add_index "events", ["specialities_id"], name: "index_events_on_specialities_id"
  add_index "events", ["speciality_id"], name: "index_events_on_speciality_id"
  add_index "events", ["starts_at"], name: "index_events_on_starts_at"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "fullcalendar_engine_event_series", force: true do |t|
    t.integer  "frequency",  default: 1
    t.string   "period",     default: "monthly"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fullcalendar_engine_events", force: true do |t|
    t.string   "title"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",         default: false
    t.text     "description"
    t.integer  "event_series_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fullcalendar_engine_events", ["event_series_id"], name: "index_fullcalendar_engine_events_on_event_series_id"

  create_table "invites", force: true do |t|
    t.integer  "attendee_id"
    t.integer  "attended_event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invites", ["attended_event_id"], name: "index_invites_on_attended_event_id"
  add_index "invites", ["attendee_id", "attended_event_id"], name: "index_invites_on_attendee_id_and_attended_event_id", unique: true
  add_index "invites", ["attendee_id"], name: "index_invites_on_attendee_id"

  create_table "news", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "redactor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "redactor_assets", ["assetable_type", "assetable_id"], name: "idx_redactor_assetable"
  add_index "redactor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_redactor_assetable_type"

  create_table "specialities", force: true do |t|
    t.string "name"
    t.string "color"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.string   "color"
    t.string   "napravlenie"
    t.datetime "birthdate"
    t.string   "phone"
    t.string   "company"
    t.string   "post"
    t.string   "city"
    t.string   "country"
    t.string   "region"
    t.string   "info"
    t.integer  "specialities_id"
    t.integer  "speciality_id"
  end

  add_index "users", ["birthdate"], name: "index_users_on_birthdate"
  add_index "users", ["city"], name: "index_users_on_city"
  add_index "users", ["color"], name: "index_users_on_color"
  add_index "users", ["company"], name: "index_users_on_company"
  add_index "users", ["country"], name: "index_users_on_country"
  add_index "users", ["info"], name: "index_users_on_info"
  add_index "users", ["napravlenie"], name: "index_users_on_napravlenie"
  add_index "users", ["phone"], name: "index_users_on_phone"
  add_index "users", ["post"], name: "index_users_on_post"
  add_index "users", ["region"], name: "index_users_on_region"
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["specialities_id"], name: "index_users_on_specialities_id"
  add_index "users", ["speciality_id"], name: "index_users_on_speciality_id"

end
