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
      districts = Osc::ParseFeed.get_districts(raw_crime.title)

      location(streets, districts)
    end

    private
    def location(streets, districts)
      lonlat = with_streets_and_districts(streets, districts)
      return lonlat if lonlat

      lonlat = with_streets(streets)
    end


    def with_streets_and_districts(streets, districts)
      streets.each do |street|
        districts.each do |district|
          lonlat = get_point(location_string(street, district))
          return lonlat if lonlat
          sleep 1
        end
      end
      return nil
    end

    def with_streets(streets)
      streets.each do |street|
        lonlat = get_point(location_string(street))
        return lonlat if lonlat
        sleep 1
      end
      return nil
    end

    def location_string(street, district = '')
      "#{street} #{district} Berlin".squish
    end
  end
end
