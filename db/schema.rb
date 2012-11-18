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

ActiveRecord::Schema.define(:version => 20121118215140) do

  create_table "crime_types", :force => true do |t|
    t.string   "name",                           :null => false
    t.string   "regex",      :default => "^.+$", :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "priority",   :default => 100
  end

  create_table "layer", :id => false, :force => true do |t|
    t.integer "topology_id",                   :null => false
    t.integer "layer_id",                      :null => false
    t.string  "schema_name",                   :null => false
    t.string  "table_name",                    :null => false
    t.string  "feature_column",                :null => false
    t.integer "feature_type",                  :null => false
    t.integer "level",          :default => 0, :null => false
    t.integer "child_id"
  end

  create_table "raw_crimes", :force => true do |t|
    t.text     "guid"
    t.text     "title"
    t.text     "link"
    t.datetime "date"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "spatial_ref_sys", :id => false, :force => true do |t|
    t.integer "srid",                      :null => false
    t.string  "auth_name", :limit => 256
    t.integer "auth_srid"
    t.string  "srtext",    :limit => 2048
    t.string  "proj4text", :limit => 2048
  end

  create_table "topology", :force => true do |t|
    t.string  "name",                         :null => false
    t.integer "srid",                         :null => false
    t.float   "precision",                    :null => false
    t.boolean "hasz",      :default => false, :null => false
  end

end
