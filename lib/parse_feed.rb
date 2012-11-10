# -*- encoding : utf-8 -*-
module Osc
  module ParseFeed
    extend self

    DISTRICTS = ["Mitte",
                 "Friedrichshain-Kreuzberg",
                 "Pankow",
                 "Charlottenburg-Wilmersdorf",
                 "Spandau",
                 "Steglitz-Zehlendorf",
                 "Tempelhof-Schöneberg",
                 "Neukölln",
                 "Treptow-Köpenick",
                 "Marzahl-Hellersdorf",
                 "Lichtenberg",
                 "Reinickendorf"]

    STREET_SUFFIXES = ["str",
                       "straß",
                       "weg",
                       "platz",
                       "damm"]

    def getDistricts(string)
      DISTRICTS.select { |district| string.match(district) }
    end

    def getStreets(string)
      return [] if string.nil?
      STREET_SUFFIXES.map do |suffix|
        street = "\\w*#{suffix}\\w*"
        cap_street = "\\w*\\s#{suffix.capitalize}\\w*"
        street_regexp = Regexp.new("(#{street}|#{cap_street})")
        string.scan(street_regexp)
      end.flatten.reject(&:empty?)
    end
  end
end
