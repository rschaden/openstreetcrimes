require 'spec_helper'

describe RawCrime do
  [:guid, :title, :link, :text, :date].each do |field|
    it { should respond_to field }
  end

  context 'validations' do
    let(:raw_crime) { FactoryGirl.create :raw_crime }

    it 'is valid' do
      raw_crime.should be_valid
    end

    it 'is not valid without guid' do
      raw_crime.guid = ""
      raw_crime.should_not be_valid
    end

    it 'does not allow duplicate guids' do
      duplicate_crime = FactoryGirl.build(:raw_crime,
                                          guid: raw_crime.guid)
      duplicate_crime.should_not be_valid
    end
  end
end
