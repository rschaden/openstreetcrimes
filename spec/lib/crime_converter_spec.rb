require 'spec_helper'
require 'osc/crime_converter'

module Osc
  describe CrimeConverter do
    subject { Osc::CrimeConverter }
    before :each do
      @raw_crime = FactoryGirl.create(:raw_crime)
    end

    context '.convert' do
      context 'create crime' do
        before :each do
          subject.convert
          @result = Crime.first
        end

        it 'sets guid' do
          @result.guid.should eq @raw_crime.guid
        end

        it 'sets description' do
          @result.description.should eq @raw_crime.title
        end

        it 'sets date' do
          @result.date.should eq @raw_crime.date.to_date
        end

        it 'sets district' do
          @result.district.should eq @raw_crime.district
        end

        it 'sets location' do
          @result.location.should eq @raw_crime.location
        end
      end

      it 'sets raw_crime.converted to true' do
        subject.convert

        @raw_crime.reload.converted.should be true
      end

      context 'convert_crime' do
        it 'does not save same crime twice' do
          subject.convert_crime(@raw_crime)
          subject.convert_crime(@raw_crime)
          Crime.count.should eq 1
        end
      end
    end
  end
end
