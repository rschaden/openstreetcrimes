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

    it 'does not allow duplicate guids' do
      duplicate_crime = FactoryGirl.build(:raw_crimes,
                                        guid: @raw_crime.guid)
      duplicate_crime.should_not be_valid
    end
  end

end
