module Osc
  module CrimeConverter
    extend self

    def convert
      RawCrime.unconverted.each do |raw_crime|
        convert_crime(raw_crime)
      end
    end

    def convert_crime(raw_crime)
      location = raw_crime.location
      if location
        crime = Crime.new(guid: raw_crime.guid,
                          description: raw_crime.title,
                          date: raw_crime.date,
                          district: raw_crime.district,
                          location: location)

        puts "Converted: #{raw_crime.short_title}" if crime.save
      end
      raw_crime.update_attribute(:converted, true)
    end
  end
end
