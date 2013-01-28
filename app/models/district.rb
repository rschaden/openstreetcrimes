class District < ActiveRecord::Base
  has_many :crimes
  has_many :crime_histories

  attr_accessible :name, :area, :population

  set_rgeo_factory_for_column(:area, Osc::GEOFACTORY.projection_factory)

  def crime_count
    District.where(id: id).joins(:crimes).count || 0
  end

  def weighted_crime_count
    crime_count * 100000.0 / population
  end

  def historic_count(year)
    year = CrimeHistory.where(district_id: id).where(year: year)
    return year.first.crime_count unless year.empty?
    0
  end

  def weighted_historic_count(year)
    historic_count(year) * 100000.0 / population
  end
end
