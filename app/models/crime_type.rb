class CrimeType < ActiveRecord::Base
  attr_accessible :name, :regex, :priority
end
