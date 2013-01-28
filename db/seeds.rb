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

#population data taken from
#http://www.berlin.de/berlin-im-ueberblick/politik/bezirke.de.html
{ 'Mitte' => 334465,
  'Friedrichshain-Kreuzberg' => 270873,
  'Pankow' => 372295,
  'Charlottenburg-Wilmersdorf' => 320835,
  'Spandau' => 226914,
  'Steglitz-Zehlendorf' => 295950,
  'Tempelhof-Schöneberg' => 336527,
  'Neukölln' => 313394,
  'Treptow-Köpenick' => 242957,
  'Marzahn-Hellersdorf' => 250713,
  'Lichtenberg' => 262192,
  'Reinickendorf' => 241824}.each do |district_name, population|
    District.where(name: district_name).first.update_attribute(:population, population)
  end
#Crime Counts for 2011:
{ 'Mitte' => 83398,
  'Friedrichshain-Kreuzberg' => 49422,
  'Pankow' => 40110,
  'Charlottenburg-Wilmersdorf' => 50516,
  'Spandau' => 27660,
  'Steglitz-Zehlendorf' => 25872,
  'Tempelhof-Schöneberg' => 40669,
  'Neukölln' => 45638,
  'Treptow-Köpenick' => 22903,
  'Marzahn-Hellersdorf' => 25544,
  'Lichtenberg' => 26372,
  'Reinickendorf' => 29014}.each do |district_name, crime_count|
    district = District.where(name: district_name).first
    CrimeHistory.create(district_id: district.id, year: 2011, crime_count: crime_count)
  end
