# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
CrimeType.add({name: "Gewalt", regex: ""})
CrimeType.add({name: "Dienstahl", regex: ""})
CrimeType.add({name: "Mord", regex: ""})
CrimeType.add({name: "Verkehrsdelikte", regex: ""})
CrimeType.add({name: "Sonstiges", regex: ""})
