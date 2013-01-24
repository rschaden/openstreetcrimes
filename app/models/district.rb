class District < ActiveRecord::Base
  has_many :crimes

  attr_accessible :name, :area, :population

  set_rgeo_factory_for_column(:area, Osc::GEOFACTORY.projection_factory)

  def crime_count
    District.where(id: id).joins(:crimes).group(:name).count.values.first || 0
  end
end
