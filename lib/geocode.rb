require 'geocoder'

module Osc
  class Geocode
    def self.get_point(location)
      point = Geocoder.coordinates(location)
      return nil if point.nil?

      factory = Osc::GEOFACTORY

      factory.point(point.second, point.first).projection
    end
  end
end
