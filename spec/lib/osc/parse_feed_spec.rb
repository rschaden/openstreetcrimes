# -*- encoding : utf-8 -*-
require 'spec_helper'

module Osc
  describe ParseFeed do
    subject { Osc::ParseFeed }
    context '.get_streets' do

      context 'fixed streets' do
        ['Adlergestell', 'Unter den Linden'].each do |fixed_street|
          it "matches #{fixed_street}" do
            subject.get_streets(fixed_street).should include fixed_street
          end
        end
      end
      STREETS = ['Alexanderplatz', 'Kurfürstendamm', 'Turmstr',
                 'Tegeler Straße', 'Friedrichsstrasse', 'Hackescher Markt',
                 'Gendarmenmarkt', 'Kottbusser Tor', 'Strasse des 17. Juni',
                 'Allee der Kosmonauten', 'Karl-Marx-Allee', 'Alte Hamburger Strasse',
                 'Görlitzer Park', 'Alt-Moabit'
      ]
      context 'other streets' do
        STREETS.each do |street|
          it "matches #{street}" do
            subject.get_streets(street).should include street
          end
        end
      end
      context 'other places' do
        ['Gehweg', 'Parkplatz'].each do |place|
          it "does not match #{place}" do
            subject.get_streets(place).should_not include place
          end
        end
      end

      context 'get_districts' do
        DISTRICTS = ['Mitte', 'Friedrichshain-Kreuzberg','Pankow',
                     'Charlottenburg-Wilmersdorf', 'Spandau', 'Steglitz-Zehlendorf',
                     'Tempelhof-Schöneberg', 'Neukölln', 'Treptow-Köpenick',
                     'Marzahn-Hellersdorf', 'Lichtenberg', 'Reinickendorf']
        DISTRICTS.each do |district|
          it "matches #{district}" do
            subject.get_districts(district).should include district
          end
        end

      end
    end
  end
end
