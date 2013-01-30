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

districts = YAML.load_file('db/district_data.yml')


districts.each do |key, district|
  District.where(name: district['name']).first.
    update_attribute(:population, district['population'])
end

CrimeHistory.delete_all
districts.each do |key, district_data|
  district = District.where(name: district_data['name']).first
  district_data['crime_history'].each do |year, crime_count|
    CrimeHistory.create(district_id: district.id,
                        year: year,
                        crime_count: crime_count)
  end
end
