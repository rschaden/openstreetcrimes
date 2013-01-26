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

    STREET_SIGNIFIER = ["stra[ss|ß]e",
                       "str",
                       "weg",
                       "platz",
                       "damm",
                        "ufer", "steg", "allee", "chaussee", "markt", "ring", "brücke"]
    FIX_STREETS = [
      "Unter den Linden", "Adlergestell"
    ]
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

    # Awesome Regex: http://rubular.com/r/bVZyPD8tWG
    def get_streets(string)
      regex_street_signifier_lowercase = STREET_SIGNIFIER.join '|'
      regex_street_signifier_capitalized = STREET_SIGNIFIER.map(&:capitalize).join '|'
      monster_regexp = /((#{regex_street_signifier_capitalized}) de[r|s] (([0-9]+\. )?\p{Lu}\p{L}+ ?)+|#{FIX_STREETS.join('|')}|\p{Lu}[\p{L}-]+(#{regex_street_signifier_lowercase})|(\p{Lu}\p{L}+[ -])+\b ?(#{regex_street_signifier_capitalized}))/
      matches = string.scan monster_regexp
      return [] if matches.nil?
      matches.uniq.map(&:first)
    end

    private
    def get_districts(string)
      DISTRICTS.select { |district| string.match(district) }
    end

  end
end
