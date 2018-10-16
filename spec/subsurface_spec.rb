# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'spec_helper'
RSpec.describe Subsurface do
  before(:each) do
    @reader = Subsurface::Reader
  end
  it 'has a version number' do
    expect(Subsurface::VERSION).not_to be nil
  end
  describe '#read' do
    context 'dives file with 1 dive' do
      before(:each) do
        @dives = @reader.read(
          Nokogiri::XML(File.open("#{RSPEC_ROOT}/files/1dive.ssrf"))
        )
      end
      it 'should return a dives array with 1 dive' do
        expect(@dives.length).to be 1
      end
      context 'the dive should have the correct' do
        before(:each) do
          @dive = @dives[0]
        end
        it 'dive number' do
          expect(@dive.number).to eq 103
        end
        it 'date' do
          expect(@dive.date).to eq '2018-07-01'
        end
        it 'duration' do
          expect(@dive.duration).to eq 65 * 60
        end
        it 'number of dive computers' do
          expect(@dive.computer_data.length).to eq 2
        end
        context 'computer data' do
          before(:each) do
            @cd = @dive.computer_data
          end
          it 'should have the correct models' do
            expect(@cd[0].model).to eq 'Shearwater Perdix AI'
            expect(@cd[1].model).to eq 'Suunto Zoop Novo'
          end
          context 'for the first computer' do
            before(:each) do
              @cd1 = @cd[0]
            end
            it 'should have the correct dive info' do
              expect(@cd1.device_id).to eq '10b852b1'
              expect(@cd1.dive_id).to eq 'ba918959'
              expect(@cd1.max_depth).to be 16.0
              expect(@cd1.mean_depth).to be 9.872
              expect(@cd1.water_temp).to be 27.0
              expect(@cd1.surface_pressure).to be 1.01
              expect(@cd1.salinity).to be 1020.0
            end
            it 'should have the correct extra data' do
              expect(@cd1.extra_datas[0].key).to eq 'Serial'
              expect(@cd1.extra_datas[0].value).to eq '37188343'
            end
            it 'should have all the samples' do
              expect(@cd1.samples.length).to be 396
            end
            context 'the second sample' do
              before(:each) do
                @sample = @cd1.samples[1]
              end
              it 'should have all the correct data' do
                expect(@sample.time).to be 20
                expect(@sample.depth).to be 3.4
                expect(@sample.pressure).to be 206.981
                expect(@sample.ndl).to be 99 * 60
              end
            end
          end
        end
      end
    end
    context 'dive file with multiple dives' do
      before(:each) do
        @dives = @reader.read(
          Nokogiri::XML(File.open("#{RSPEC_ROOT}/files/multiple_dives.ssrf"))
        )
      end
      it 'should return a dives array with 6 dives' do
        expect(@dives.length).to be 6
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
