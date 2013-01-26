require 'crime_converter'

namespace :osc do
  desc "Converts new RawCrimes"
  task :convert_crimes => :environment do
    Osc::CrimeConverter.convert
  end
end
