require 'spec_helper'
# require 'parse_feed'

describe RawCrime do

  RAW_CRIME_FIELDS = [:guid, :title, :link, :text, :date]

  RAW_CRIME_FIELDS.each do |field|
    it { should respond_to field }
  end

  context 'validations' do
    before :each do
      @raw_crime = FactoryGirl.create :raw_crimes
    end

    it 'is valid' do
      @raw_crime.should be_valid
    end

    it 'is not valid without guid' do
      @raw_crime.guid = ""
      @raw_crime.should_not be_valid
    end

    it 'does not allow duplicate guids' do
      duplicate_crime = FactoryGirl.build(:raw_crimes,
                                          guid: @raw_crime.guid)
      duplicate_crime.should_not be_valid
    end
  end

  context '#location_string' do
    before :each do
      @raw_crime = FactoryGirl.create :raw_crimes
    end

    [{ street: '', district: '' },
     { street: 'Lange Strasse', district: '' },
     { street: '', district: 'Mitte' },
     { street: 'Lange Strasse', district: 'Mitte' },
    ].each do |elem|
      it "with street='#{elem[:street]}' and district='#{elem[:district]}'" do
        Osc::ParseFeed.stub(:street).and_return elem[:street]
        Osc::ParseFeed.stub(:district).and_return elem[:district]

        expected = "#{elem[:street]} #{elem[:district]} Berlin".squish
        @raw_crime.location_string.should eq expected
      end
    end
  end

end
