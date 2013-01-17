# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CrimeType.delete_all
CrimeType.create({name: "Gewalt", regex: "(attack|Messer|Überfall|Sch[uü]ss|Vergewaltig|Stich)", priority: 10})
CrimeType.create({name: "Diebstahl und Raub", regex: "(Dieb|Diebstahl|gestohlen|Raub\>|Räuber)", priority: 20})
CrimeType.create({name: "Mord und Totschlag", regex: "(Mord|Tötung)", priority: 30})
CrimeType.create({name: "Verkehrsdelikte", regex: "(Verkehrsunfall|ramm|Vorfahrt)", priority: 40})
CrimeType.create({name: "Vandalismus", regex: "(Vandalismus|gesprengt|zerstört)", priority: 50})
CrimeType.create({name: "Sonstiges", regex: "^.+$", priority: 99})

db_conf = Rails.configuration.database_configuration[Rails.env]
berlin_osm_target = File.join Rails.root, "db/berlin.osm.bz2"

unless File.exists? berlin_osm_target
  `wget -O #{berlin_osm_target} http://download.geofabrik.de/openstreetmap/europe/germany/berlin.osm.bz2`
  `osm2pgsql -d #{db_conf['database']} #{berlin_osm_target}`

  District.delete_all
  sql = "INSERT INTO districts(name, area, created_at, updated_at) SELECT name, way, NOW(),NOW() FROM planet_osm_polygon WHERE boundary='administrative' AND admin_level='9' AND place='borough'"
  ActiveRecord::Base.establish_connection
  ActiveRecord::Base.connection.execute(sql)
end


