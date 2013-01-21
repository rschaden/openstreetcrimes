require 'geocode'
class MapsController < ApplicationController
  def index
    @center =  Osc::Geocode.get_point("Berlin")
    @districts = District.all

    render layout: 'maps'
  end

  def district_heatmap
    @center =  Osc::Geocode.get_point("Berlin")
    #add random count (0-100) to districts
    @districts = District.all.map{ |district| district.attributes.merge('count' => rand(100)) }
    district_data_points

    render layout: 'maps'
  end
end
