# -*- encoding : utf-8 -*-
module Osc
  module ParseFeed
    extend self

    include ActionView::Helpers::SanitizeHelper

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

    STREET_SUFFIXES = ["straße",
                       "str",
                       "weg",
                       "platz",
                       "damm"]

    def district(string)
      districts = get_districts(string)
      return "" if districts.empty?

      districts.first
    end

    def street(string)
      streets = get_streets(string)
      return "" if streets.empty?

      streets.first
    end

    private
    def get_districts(string)
      DISTRICTS.select { |district| string.match(district) }
    end

    def get_streets(string)
      return [] if string.nil?
      STREET_SUFFIXES.map do |suffix|
        street = "\\p{Word}*#{suffix}\\b"
        cap_street = street.gsub("#{suffix}", "\\s#{suffix.capitalize}")
        street_regexp = Regexp.new("(#{street}|#{cap_street})")
          # require 'pry'; binding.pry
          string.scan(street_regexp)
      end.flatten.reject(&:empty?)
    end
  end
end
