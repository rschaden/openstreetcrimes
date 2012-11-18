# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CrimeType.create({name: "Gewalt", regex: "(attack|Messer|Überfall|Sch[uü]ss|Vergewaltig|Stich)", priority: 10})
CrimeType.create({name: "Diebstahl und Raub", regex: "(Dieb|Diebstahl|gestohlen|Raub\>|Räuber)", priority: 20})
CrimeType.create({name: "Mord und Totschlag", regex: "(Mord|Tötung)", priority: 30})
CrimeType.create({name: "Verkehrsdelikte", regex: "(Verkehrsunfall|ramm|Vorfahrt)", priority: 40})
CrimeType.create({name: "Vandalismus", regex: "(Vandalismus|gresprengt|zerstört)", priority: 50})
CrimeType.create({name: "Sonstiges", regex: "^.+$", priority: 99})
