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

ActiveRecord::Schema.define(:version => 20130122115018) do

  create_table "crime_types", :force => true do |t|
    t.string   "name",                           :null => false
    t.string   "regex",      :default => "^.+$", :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "priority",   :default => 100
  end

  create_table "crimes", :force => true do |t|
    t.string   "description"
    t.date     "date"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.integer  "crime_type_id"
    t.integer  "district_id"
    t.spatial  "location",      :limit => {:srid=>900913, :type=>"point"}
  end

  add_index "crimes", ["location"], :name => "index_crimes_on_location", :spatial => true

  create_table "districts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.spatial  "area",       :limit => {:srid=>900913, :type=>"polygon"}
    t.integer  "population"
  end

  add_index "districts", ["area"], :name => "index_districts_on_area", :spatial => true

  create_table "planet_osm_line", :id => false, :force => true do |t|
    t.integer "osm_id"
    t.text    "access"
    t.text    "addr:housename"
    t.text    "addr:housenumber"
    t.text    "addr:interpolation"
    t.text    "admin_level"
    t.text    "aerialway"
    t.text    "aeroway"
    t.text    "amenity"
    t.text    "area"
    t.text    "barrier"
    t.text    "bicycle"
    t.text    "brand"
    t.text    "bridge"
    t.text    "boundary"
    t.text    "building"
    t.text    "construction"
    t.text    "covered"
    t.text    "culvert"
    t.text    "cutting"
    t.text    "denomination"
    t.text    "disused"
    t.text    "embankment"
    t.text    "foot"
    t.text    "generator:source"
    t.text    "harbour"
    t.text    "highway"
    t.text    "historic"
    t.text    "horse"
    t.text    "intermittent"
    t.text    "junction"
    t.text    "landuse"
    t.text    "layer"
    t.text    "leisure"
    t.text    "lock"
    t.text    "man_made"
    t.text    "military"
    t.text    "motorcar"
    t.text    "name"
    t.text    "natural"
    t.text    "oneway"
    t.text    "operator"
    t.text    "population"
    t.text    "power"
    t.text    "power_source"
    t.text    "place"
    t.text    "railway"
    t.text    "ref"
    t.text    "religion"
    t.text    "route"
    t.text    "service"
    t.text    "shop"
    t.text    "sport"
    t.text    "surface"
    t.text    "toll"
    t.text    "tourism"
    t.text    "tower:type"
    t.text    "tracktype"
    t.text    "tunnel"
    t.text    "water"
    t.text    "waterway"
    t.text    "wetland"
    t.text    "width"
    t.text    "wood"
    t.integer "z_order"
    t.float   "way_area"
    t.spatial "way",                :limit => {:srid=>900913, :type=>"line_string"}
  end

  add_index "planet_osm_line", ["way"], :name => "planet_osm_line_index", :spatial => true

  create_table "planet_osm_point", :id => false, :force => true do |t|
    t.integer "osm_id"
    t.text    "access"
    t.text    "addr:housename"
    t.text    "addr:housenumber"
    t.text    "addr:interpolation"
    t.text    "admin_level"
    t.text    "aerialway"
    t.text    "aeroway"
    t.text    "amenity"
    t.text    "area"
    t.text    "barrier"
    t.text    "bicycle"
    t.text    "brand"
    t.text    "bridge"
    t.text    "boundary"
    t.text    "building"
    t.text    "capital"
    t.text    "construction"
    t.text    "covered"
    t.text    "culvert"
    t.text    "cutting"
    t.text    "denomination"
    t.text    "disused"
    t.text    "ele"
    t.text    "embankment"
    t.text    "foot"
    t.text    "generator:source"
    t.text    "harbour"
    t.text    "highway"
    t.text    "historic"
    t.text    "horse"
    t.text    "intermittent"
    t.text    "junction"
    t.text    "landuse"
    t.text    "layer"
    t.text    "leisure"
    t.text    "lock"
    t.text    "man_made"
    t.text    "military"
    t.text    "motorcar"
    t.text    "name"
    t.text    "natural"
    t.text    "oneway"
    t.text    "operator"
    t.text    "poi"
    t.text    "population"
    t.text    "power"
    t.text    "power_source"
    t.text    "place"
    t.text    "railway"
    t.text    "ref"
    t.text    "religion"
    t.text    "route"
    t.text    "service"
    t.text    "shop"
    t.text    "sport"
    t.text    "surface"
    t.text    "toll"
    t.text    "tourism"
    t.text    "tower:type"
    t.text    "tunnel"
    t.text    "water"
    t.text    "waterway"
    t.text    "wetland"
    t.text    "width"
    t.text    "wood"
    t.integer "z_order"
    t.spatial "way",                :limit => {:srid=>900913, :type=>"point"}
  end

  add_index "planet_osm_point", ["way"], :name => "planet_osm_point_index", :spatial => true

  create_table "planet_osm_polygon", :id => false, :force => true do |t|
    t.integer "osm_id"
    t.text    "access"
    t.text    "addr:housename"
    t.text    "addr:housenumber"
    t.text    "addr:interpolation"
    t.text    "admin_level"
    t.text    "aerialway"
    t.text    "aeroway"
    t.text    "amenity"
    t.text    "area"
    t.text    "barrier"
    t.text    "bicycle"
    t.text    "brand"
    t.text    "bridge"
    t.text    "boundary"
    t.text    "building"
    t.text    "construction"
    t.text    "covered"
    t.text    "culvert"
    t.text    "cutting"
    t.text    "denomination"
    t.text    "disused"
    t.text    "embankment"
    t.text    "foot"
    t.text    "generator:source"
    t.text    "harbour"
    t.text    "highway"
    t.text    "historic"
    t.text    "horse"
    t.text    "intermittent"
    t.text    "junction"
    t.text    "landuse"
    t.text    "layer"
    t.text    "leisure"
    t.text    "lock"
    t.text    "man_made"
    t.text    "military"
    t.text    "motorcar"
    t.text    "name"
    t.text    "natural"
    t.text    "oneway"
    t.text    "operator"
    t.text    "population"
    t.text    "power"
    t.text    "power_source"
    t.text    "place"
    t.text    "railway"
    t.text    "ref"
    t.text    "religion"
    t.text    "route"
    t.text    "service"
    t.text    "shop"
    t.text    "sport"
    t.text    "surface"
    t.text    "toll"
    t.text    "tourism"
    t.text    "tower:type"
    t.text    "tracktype"
    t.text    "tunnel"
    t.text    "water"
    t.text    "waterway"
    t.text    "wetland"
    t.text    "width"
    t.text    "wood"
    t.integer "z_order"
    t.float   "way_area"
    t.spatial "way",                :limit => {:srid=>900913, :type=>"geometry"}
  end

  add_index "planet_osm_polygon", ["way"], :name => "planet_osm_polygon_index", :spatial => true

  create_table "planet_osm_roads", :id => false, :force => true do |t|
    t.integer "osm_id"
    t.text    "access"
    t.text    "addr:housename"
    t.text    "addr:housenumber"
    t.text    "addr:interpolation"
    t.text    "admin_level"
    t.text    "aerialway"
    t.text    "aeroway"
    t.text    "amenity"
    t.text    "area"
    t.text    "barrier"
    t.text    "bicycle"
    t.text    "brand"
    t.text    "bridge"
    t.text    "boundary"
    t.text    "building"
    t.text    "construction"
    t.text    "covered"
    t.text    "culvert"
    t.text    "cutting"
    t.text    "denomination"
    t.text    "disused"
    t.text    "embankment"
    t.text    "foot"
    t.text    "generator:source"
    t.text    "harbour"
    t.text    "highway"
    t.text    "historic"
    t.text    "horse"
    t.text    "intermittent"
    t.text    "junction"
    t.text    "landuse"
    t.text    "layer"
    t.text    "leisure"
    t.text    "lock"
    t.text    "man_made"
    t.text    "military"
    t.text    "motorcar"
    t.text    "name"
    t.text    "natural"
    t.text    "oneway"
    t.text    "operator"
    t.text    "population"
    t.text    "power"
    t.text    "power_source"
    t.text    "place"
    t.text    "railway"
    t.text    "ref"
    t.text    "religion"
    t.text    "route"
    t.text    "service"
    t.text    "shop"
    t.text    "sport"
    t.text    "surface"
    t.text    "toll"
    t.text    "tourism"
    t.text    "tower:type"
    t.text    "tracktype"
    t.text    "tunnel"
    t.text    "water"
    t.text    "waterway"
    t.text    "wetland"
    t.text    "width"
    t.text    "wood"
    t.integer "z_order"
    t.float   "way_area"
    t.spatial "way",                :limit => {:srid=>900913, :type=>"line_string"}
  end

  add_index "planet_osm_roads", ["way"], :name => "planet_osm_roads_index", :spatial => true

  create_table "raw_crimes", :id => false, :force => true do |t|
    t.text     "guid",       :null => false
    t.text     "title"
    t.text     "link"
    t.datetime "date"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
