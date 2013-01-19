require 'geocode'
class MapsController < ApplicationController
  def index
    @center =  Osc::Geocode.get_point("Berlin")

    @districts = District.all

    render layout: 'maps'
  end
end
