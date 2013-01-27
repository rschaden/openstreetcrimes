class Crime < ActiveRecord::Base
  belongs_to :crime_type
  belongs_to :district

  attr_accessible :guid, :date, :description, :location, :district

  validates :guid, presence: true, uniqueness: true

  set_rgeo_factory_for_column(:location, Osc::GEOFACTORY.projection_factory)
end
