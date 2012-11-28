class District < ActiveRecord::Base
  has_many :crimes

  attr_accessible :name, :area

  set_rgeo_factory_for_column(:area, Osc::GEOFACTORY)
end
