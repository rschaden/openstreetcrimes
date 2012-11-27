require 'geocoder'

module Osc
  class Geocode
    def self.get_point(location)
      point = Geocoder.coordinates(location)
      factory = RGeo::Geographic.simple_mercator_factory

      factory.point(point.second, point.first)
    end
  end
end
