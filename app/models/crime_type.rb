class CrimeType < ActiveRecord::Base
  has_many :crimes

  attr_accessible :name, :regex, :priority
end
