class Crime < ActiveRecord::Base
  belongs_to :crime_type
  belongs_to :district

  attr_accessible :date, :description, :location

  set_rgeo_factory_for_column(:location, Osc::GEOFACTORY.projection_factory)
end
