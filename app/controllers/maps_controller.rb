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
    @districts = District.all.map do |district|
      # district.attributes.merge('count' => district.crime_count,
      #                          'weighted_count' => district.weighted_crime_count)
      district.attributes.merge('count' => rand(100),
                               'weighted_count' => rand(20))
    end

    district_counts = @districts.map { |district| district['count'] }
    weighted_counts = @districts.map { |district| district['weighted_count'] }
    @quantils = get_quantil_hash(district_counts, weighted_counts)
    @colors = ['#00ff00', '#ffff00', '#df7401', '#df0101']

    render layout: 'maps'
  end

  private
  def get_quantil_hash(district_counts, weighted_counts)
    result = {}
    result[:normal] = get_quantils(district_counts, 0)
    result[:weighted] = get_quantils(weighted_counts, 2)

    result
  end

  def get_quantils(list, precision)
    mean = get_mean list
    standard_deviation = get_standard_deviation list
    [(mean-standard_deviation).round(precision),
     (mean).round(precision),
     (mean+standard_deviation).round(precision)]
  end

  def get_mean(list)
    list.inject(:+).to_f / list.size
  end

  def get_standard_deviation(list)
    mean = get_mean(list)
    squared_differences = list.map{ |e| (e-mean)**2 }

    Math.sqrt(get_mean(squared_differences))
  end
end
