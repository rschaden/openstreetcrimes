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
  end
end
