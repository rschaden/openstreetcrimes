class District < ActiveRecord::Base
  has_many :crimes

  attr_accessible :name
end
