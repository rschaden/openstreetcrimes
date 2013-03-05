# OpenStreetCrimes

OpenStreetCrimes is a proof of concept project to demonstrate the use of modern
web technologies in combination with geo-spatial data, visualization concepts
and such.

You can find OpenStreetCrimes' source code at Github: https://github.com/rschaden/openstreetcrimes

It was part of a Spatial DB related University Project at [Freie Universität
Berlin](http://mi.fu-berlin.de/) in Winter 2012/2013. The lecture was held by
[Prof. Agnès Voisard](http://page.mi.fu-berlin.de/voisard/) and assisted by
[Daniel Kressner](http://kressnerd.de/).

Main contributers were [@hendrikb](https://github.com/hendrikb) and [@rschaden](https://github.com/rschaden).

A demo of the application in action can be seen at the Lange Nacht der
Wissenschaften in Berlin, on June 8, 2013 at the Department of Computer
Science, Freie Universität Berlin, Takustr. 9, 14195 Berlin.

## About

This project uses the RSS newsfeed from the Berlin Police Department to fetch
information about crime (and similar) incidents, geocodes them and stores them
into a spatial database. A ruby on rails application acts as a visualization
layer and provides several views on the aggregated incident data. It currently
supports heat-maps and colored districts for live data and historic data.

### Used Technologies

* RGeo - geospatial data library for Ruby,  https://github.com/dazuma/rgeo
* PostgreSQL with PostGIS, a relational database management system and its
  geospatial extension, http://postgis.org/
* PostGIS ActiveRecord Adapter,
  https://github.com/dazuma/activerecord-postgis-adapter
* Feedzirra - Feed parsing gem, https://github.com/pauldix/feedzirra
* Geocoder - geocoding/reverse geocoding gem,
    https://github.com/alexreisner/geocoder
* OpenLayers - JavaScript library for maps, http://openlayers.org/
* heatmap.js - Heatmaps in JavaScript,
      http://www.patrick-wied.at/static/heatmapjs/

## How things work

Actually the approach is very straight forward. There's a [rake
task](https://github.com/rschaden/openstreetcrimes/blob/master/lib/tasks/importer.rake)
that must be invoked to fetch the newest incident reportings from the police
news feed. This task is called by ```rake osc:fetch_feeds``` on the console.
This is likely to be run every once in a while by a cronjob.

This task writes all newly available incidents into the database using the
[RawCrime-Model](https://github.com/rschaden/openstreetcrimes/blob/master/app/models/raw_crime.rb).
This is some form of unprocessed, non-spatial caching, as there are only
twenty-something events listed in the newsfeed and we collect them to just have
them available when we need them.

Magic comes into play, when these RawCrime-Events get converted to
[Crime](https://github.com/rschaden/openstreetcrimes/blob/master/app/models/crime.rb)
model instances by invoking the
[crime_converter](https://github.com/rschaden/openstreetcrimes/blob/master/lib/tasks/crime_converter.rake)
rake task by hacking ```rake osc:convert_crimes``` into the shell.

All RawCrimes that have not yet been converted into ("real") Crimes are now ...
* ... being converted into an instance of the Crime Model
* ... parsed for street/place/district names
* ... geocoded (trying to find an exact Langitude/Longitude location for a
  found street/place name)
* ... saved in the crimes table (managed by Crime-Model, Ruby on Rails style).

Having geocoded, spatial data enriched Crimes in the database allows us to open
the web browser and access the GUI. There are two modes of operation:

1. It'll show us a heat map with all available Crimes on it, coloring the areas
   with a high frequency of ("let's say it is just...") events.
2. It can also show us a colored map with all of Berlin's districts. Depending
   on the coloring one can guess how much fuzz is going on in each of the
   districts. This mode can be applied by historic data from 2011 that is
   complete or from the converted Crimes, downloaded from the Berlin Police
   Department, as described above.

## Installation

In general it makes sense to know some basics about Postgis and especially Ruby on Rails.

### Setting up the Database

What you definitely have to have installed and properly configured is a Postgres database (at least v9.1), equipped with a recent version of the Postgis extension (at least v2.0!).

Short Story: To be honest, we had some issues to put up everything with the standard Ubuntu apt-system, so we basically installed PostreSQL via sudo ```apt-get install postgresql-server-dev-9.1``` and compiled postgis manually via ```./configure && make && make install``` (of course we had to deal with all the dependency library stuff beforehand, I'm walking about gcc, make, Proj4, GEOS, LibXML2, JSON-C and GDAL). There are excellent docs about the [installation of postgis](http://postgis.net/docs/manual-2.0/).

However, the long version is this (we're using Ubuntu Server 12.04):

```
# Install PostgreSQL
$ sudo apt-get install postgresql postgresql-server-dev-9.1  postgresql-client-9.1

# Install dependencies for PostGIS
$ sudo apt-get install build-essential libxml2-dev automake libtool libbz2-dev

$ mkdir -p ~/code
$ cd ~/code

# INSTALL THE DEPENDENCIES

# Install PROJ
$ wget http://download.osgeo.org/proj/proj-4.8.0.tar.gz
$ tar xfvz proj-4.8.0.tar.gz
$ cd proj-4.8.0/
$ ./configure && make && sudo make install
$ cd ..

# Install GEOS
$ wget http://download.osgeo.org/geos/geos-3.3.8.tar.bz2
$ tar xfvj geos-3.3.8.tar.bz2
$ cd geos-3.3.8/
$ ./configure && make && sudo make install
$ cd ..

# Install JSON-C
$ wget http://oss.metaparadigm.com/json-c/json-c-0.9.tar.gz
$ tar xfvz json-c-0.9.tar.gz
$ cd cd json-c-0.9/
$ ./configure && make && sudo make install
$ cd ..

# Install GDAL
$ wget http://download.osgeo.org/gdal/gdal-1.9.2.tar.gz
$ tar xfvz gdal-1.9.2.tar.gz
$ cd gdal-1.9.2/
$ ./configure && make && sudo make install # this takes a while!
$ cd ..


## FINALLY INSTALL POSTGIS:

$ wget http://download.osgeo.org/postgis/source/postgis-2.0.3.tar.gz
$ tar xfvz postgis-2.0.3.tar.gz
$ cd postgis-2.0.3
$ ./configure && make && sudo make install

$ sudo service postgresql restart

```

### Setting up Ruby

```
$ sudo apt-get install ruby1.9.3
```

Heavens, that was easy. Now update the ruby packaging system (rubygems and bundler).

```
$ sudo gem update
$ sudo gem install bundler
```

### Setting up OpenStreetCrimes

```
# We need these additional libraries and tools for our project:
$ sudo apt-get git install libcurl4-gnutls-dev libxslt1-dev

# Install openstreetcrimes:

$ cd ~/code
$ git clone git://github.com/rschaden/openstreetcrimes.git
$ cd openstreetcrimes
$ sudo bundle install # this can be heavily optimized by using RVM on a production system

# Create a database user and use your brain while doing so!
$  sudo -u postgres psql -c "CREATE ROLE openstreetcrimes WITH SUPERUSER LOGIN PASSWORD 'ChangeMeQuickly'"

# create the databases (test, production and development, as usually in rails)
# and enable access and enable the postgis extension on each of them

$  sudo -u postgres psql -c "CREATE DATABASE openstreetcrimes_dev WITH OWNER = openstreetcrimes"
$  sudo -u postgres psql -c "CREATE DATABASE openstreetcrimes_test WITH OWNER = openstreetcrimes"

$  sudo -u postgres psql -U openstreetcrimes -W -h 127.0.0.1 -c "CREATE EXTENSION postgis" openstreetcrimes_dev
$  sudo -u postgres psql -U openstreetcrimes -W -h 127.0.0.1 -c "CREATE EXTENSION postgis" openstreetcrimes_test

# Create the database configuration for the recently created database database user
$ cp config/db.yml.template config/database.yml
```

Okay, we've come pretty far here. Everything technical should be quite set up now. Let's continue with loading
some data into the database now.

TODO

$




TODO

## Known Problems

We know this is far from being perfect. This project was more or less a homework assignment. We know, that there are a couple of coding inconsistencies, dealing with the database might be a little inefficient and when it comes to representativeness, we're basically mixing up data about serious car crashes with crime-incidents - so OpenStreetCRIMES is not about crimes alone, but about the things that happen in Berlin that the Police department talks about.

## Contribution and TODOs
If you want to contribute in ANY WAY, your help is very much appreciated. Just fork the project, do your changes, add some specs (it's not a MUST but it's a BIG PLUS) push your changes to your repo and file a pull request on GitHub. We'll review it and merge your features or bug fixes if everything looks good. :) Thanks in advance.

How could you help us? Well, here are some ideas:

* make OpenStreetCrimes a more general thing: add support for different areas, cities or even states...?!
* fix any bug you find
* increase test coverage
* convert the views from ERB to HAML
* refactor
* clean up the code
* Improve the README and/or documentation
* Improve ANYTHING ELSE
