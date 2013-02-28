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

## Installation

### Prerequisites


