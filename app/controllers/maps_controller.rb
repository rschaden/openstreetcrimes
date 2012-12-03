require 'geocode'
class MapsController < ApplicationController
  def index
    @center =  Osc::Geocode.get_point("Berlin")

    @districts = District.all.map(&:area).map(&:to_s)
  end
end
