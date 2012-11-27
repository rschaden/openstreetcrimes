class Crime < ActiveRecord::Base
  belongs_to :crime_type
  belongs_to :district

  attr_accessible :date, :description, :location
end
