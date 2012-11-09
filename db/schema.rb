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

ActiveRecord::Schema.define(:version => 20121108150720) do

  create_table "layer", :id => false, :force => true do |t|
    t.integer "topology_id",                                  :null => false
    t.integer "layer_id",                                     :null => false
    t.string  "schema_name",    :limit => nil,                :null => false
    t.string  "table_name",     :limit => nil,                :null => false
    t.string  "feature_column", :limit => nil,                :null => false
    t.integer "feature_type",                                 :null => false
    t.integer "level",                         :default => 0, :null => false
    t.integer "child_id"
  end

  create_table "raw_crimes", :force => true do |t|
    t.string   "guid"
    t.string   "title"
    t.string   "link"
    t.datetime "date"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "topology", :force => true do |t|
    t.string  "name",      :limit => nil,                    :null => false
    t.integer "srid",                                        :null => false
    t.float   "precision",                                   :null => false
    t.boolean "hasz",                     :default => false, :null => false
  end

end