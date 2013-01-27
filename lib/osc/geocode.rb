require 'geocoder'

module Osc
  module Geocode
    extend self

    def get_point(location)
      lonlat = get_lonlat(location)
      lonlat.projection if lonlat
    end

    def get_lonlat(location)
      point = Geocoder.coordinates(location)
      return nil if point.nil?

      factory = Osc::GEOFACTORY

      factory.point(point.second, point.first)
    end

    def raw_crime(raw_crime)
      streets = Osc::ParseFeed.get_streets(raw_crime.text)
      districts = Osc::ParseFeed.get_streets(raw_crime.title)

      location(streets, districts)
    end

    private
    def location(streets, districts)
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

    def location_string(street, district = '')
      "#{street} #{district} Berlin".squish
    end
  end
end
