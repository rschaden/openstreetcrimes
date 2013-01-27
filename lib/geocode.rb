require 'geocoder'

module Osc
  class Geocode
    def self.get_point(location)
      lonlat = get_lonlat(location)
      lonlat.projection if lonlat
    end

    def self.get_lonlat(location)
      point = Geocoder.coordinates(location)
      return nil if point.nil?

      factory = Osc::GEOFACTORY

      factory.point(point.second, point.first)
    end

    def self.raw_crime(raw_crime)
      streets = Osc::ParseFeed.get_streets(raw_crime.text)
      districts = Osc::ParseFeed.get_streets(raw_crime.title)

      self.location(streets, districts)
    end

    private
    def self.location(streets, districts)
      streets.each do |street|
        districts.each do |district|
          lonlat = get_point(location_string(street, district))
          return lonlat if lonlat
          sleep 1
        end
        if districts.empty?
          lonlat = get_point(location_string(street))
          return lonlat if lonlat
          sleep 1
        end
      end
      return nil
    end

    def self.location_string(street, district = '')
      "#{street} #{district} Berlin".squish
    end
  end
end
