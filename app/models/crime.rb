class Crime < ActiveRecord::Base
  belongs_to :crime_type

  attr_accessible :date, :description, :location
end
