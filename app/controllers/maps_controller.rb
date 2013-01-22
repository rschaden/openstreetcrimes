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

    district_counts = @districts.map { |district| district['count'] }
    mean = get_mean district_counts
    standard_deviation = get_standard_deviation district_counts
    @quantils = [(mean-standard_deviation).floor,
                (mean).floor,
                (mean+standard_deviation).floor]

    render layout: 'maps'
  end

  private
  def get_mean(list)
    list.inject(:+).to_f / list.size
  end

  def get_standard_deviation(list)
    mean = get_mean(list)
    squared_differences = list.map{ |e| (e-mean)**2 }

    Math.sqrt(get_mean(squared_differences))
  end
end
