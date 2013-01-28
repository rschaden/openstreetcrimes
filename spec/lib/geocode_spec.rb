require 'spec_helper'

module Osc
  describe Geocode do
    subject { Osc::Geocode }

    context '.get_point' do
      it 'finds a mercator point for Berlin' do
        subject.get_point('Berlin').should be_kind_of RGeo::Geos::CAPIPointImpl
      end

      it 'does not find non existing address' do
        subject.get_point('Brandenburger Tor Spandau Berlin').should be nil
      end
    end

    context '.get_lonlat' do
      it 'finds a lonlat point for Berlin' do
        subject.get_lonlat('Berlin').should be_kind_of RGeo::Geographic::ProjectedPointImpl
      end

      it 'does not find non existing address' do
        subject.get_lonlat('Brandenburger Tor Spandau Berlin').should be nil
      end
    end

    context '.raw_crime' do
      let(:raw_crime_mock) { mock(text: 'text', title: 'title') }

      shared_examples 'valid address' do
        it 'finds a location' do
          subject.raw_crime(raw_crime_mock).should be_kind_of RGeo::Geos::CAPIPointImpl
        end
      end

      context 'with just a street' do
        before do
          Osc::ParseFeed.should_receive(:get_streets).with('text').
            and_return ['Turmstrasse']
          Osc::ParseFeed.should_receive(:get_districts).with('title').
            and_return []
        end

        it_behaves_like 'valid address'
      end

      context 'with a street and district' do
        before do
          Osc::ParseFeed.should_receive(:get_streets).with('text').
            and_return ['Turmstrasse']
          Osc::ParseFeed.should_receive(:get_districts).with('title').
            and_return ['Mitte']
        end

        it_behaves_like 'valid address'
      end
      context 'with a street and districts in wrong order' do
        before do
          Osc::ParseFeed.should_receive(:get_streets).with('text').
            and_return ['Turmstrasse']
          Osc::ParseFeed.should_receive(:get_districts).with('title').
            and_return ['Spandau', 'Mitte']
        end

        it_behaves_like 'valid address'
      end

      context 'with street and non matching district' do
        before do
          Osc::ParseFeed.should_receive(:get_streets).with('text').
            and_return ['Turmstrasse']
          Osc::ParseFeed.should_receive(:get_districts).with('title').
            and_return ['Spandau']
        end

        it_behaves_like 'valid address'
      end

      context 'with multiple streets and districts' do
        before do
          Osc::ParseFeed.should_receive(:get_streets).with('text').
            and_return ['Quatschstrasse', 'Turmstrasse']
          Osc::ParseFeed.should_receive(:get_districts).with('title').
            and_return ['Mitte', 'Pankow']
        end

        it_behaves_like 'valid address'
      end

      context 'non matching' do
        it 'returns nil' do
          Osc::ParseFeed.should_receive(:get_streets).with('text').
            and_return ['Quatschstrasse','Testrasse']
          Osc::ParseFeed.should_receive(:get_districts).with('title').
            and_return ['Spandau', 'Mitte']

          subject.raw_crime(raw_crime_mock).should be nil
        end
      end
    end
  end
end
