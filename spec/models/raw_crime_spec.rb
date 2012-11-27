require 'spec_helper'

describe RawCrimes do

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

    it 'without a street and district' do
      Osc::ParseFeed.stub(:street).and_return ''
      Osc::ParseFeed.stub(:district).and_return ''

      @raw_crime.location_string.should eq 'Berlin'
    end

    it 'with only a district' do
      Osc::ParseFeed.stub(:street).and_return ''
      Osc::ParseFeed.stub(:district).and_return 'Mitte'

      @raw_crime.location_string.should eq 'Mitte Berlin'
    end

    it 'with only a street' do
      Osc::ParseFeed.stub(:street).and_return 'Lange Strasse'
      Osc::ParseFeed.stub(:district).and_return ''

      @raw_crime.location_string.should eq 'Lange Strasse Berlin'
    end

    it 'with both street and district' do
      Osc::ParseFeed.stub(:street).and_return 'Lange Strasse'
      Osc::ParseFeed.stub(:district).and_return 'Mitte'

      @raw_crime.location_string.should eq 'Lange Strasse Mitte Berlin'
    end
  end

end
