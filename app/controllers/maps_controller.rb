require 'geocode'
class MapsController < ApplicationController
  def index
    point =  Osc::Geocode.get_point("Berlin")
    @lat = point.lat
    @lon = point.lon

    @districts = District.all.map(&:area).map(&:to_s)
  end
end
