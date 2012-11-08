class RawCrimes < ActiveRecord::Base
  attr_accessible :date, :guid, :link, :text, :title

  validates :guid, presence: true, uniqueness: true
end
