class CrimeHistory < ActiveRecord::Base
  belongs_to :district
  attr_accessible :crime_count, :district_id, :year
end
