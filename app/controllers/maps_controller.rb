class MapsController < ApplicationController
  def index
    @title = "Recent Data Heat Map"
    @site = :index
    @center =  Osc::Geocode.get_point("Berlin")
    @districts = District.all
    @crimes = Crime.all.map { |crime| { description: crime.description,
                                        lon: crime.lon,
                                        lat: crime.lat }}

    render layout: 'maps'
  end

  def district_heatmap
    @site = :district_heatmap
    @title = "Recent Crime Data - by Districts"
    @center =  Osc::Geocode.get_point("Berlin")
    @districts = District.all.map do |district|
      district.attributes.merge('count' => district.crime_count,
                                'weighted_count' => district.weighted_crime_count)
    end

    @quantils = get_quantil_hash(@districts)
    @colors = ['#00ff00', '#ffff00', '#df7401', '#df0101']

    render layout: 'maps'
  end

  def historic_heatmap
    @site = :historic_heatmap
    @title = "Historic Crime Data (2011) - by Districts"
    @center =  Osc::Geocode.get_point("Berlin")
    @districts = District.all.map do |district|
      district.attributes.merge('count' => district.historic_count(2011),
                                'weighted_count' => district.weighted_historic_count(2011))
    end

    @quantils = get_quantil_hash(@districts)
    @colors = ['#00ff00', '#ffff00', '#df7401', '#df0101']

    render layout: 'maps'
  end

  private
  def get_quantil_hash(districts)
    district_counts = districts.map { |district| district['count'] }
    weighted_counts = districts.map { |district| district['weighted_count'] }
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
