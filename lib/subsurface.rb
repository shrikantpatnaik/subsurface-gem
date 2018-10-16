# frozen_string_literal: true

require 'subsurface/version'
require 'subsurface/extra_data'
require 'subsurface/sample'
require 'subsurface/computer_data'
require 'subsurface/dive'
# rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/ClassLength
# main reader class
module Subsurface
  # Reader is the main class that reads the xml data
  class Reader
    def self.read(data)
      dives = []
      data.xpath('//dive').each do |dive|
        computer_data = []
        dive.xpath('divecomputer').each do |computer|
          extra_datas = []
          computer.xpath('extradata').each do |ed|
            extra_datas.push(
              ExtraData.new(
                get_attribute_value(ed, nil, 'key'),
                get_attribute_value(ed, nil, 'value')
              )
            )
          end
          samples = []
          computer.xpath('sample').each do |sample|
            samples.push(create_sample(sample))
          end
          computer_data.push(
            create_computer_data(computer, extra_datas, samples)
          )
        end
        dives.push(create_dive(dive, computer_data))
      end
      dives
    end

    class << self
      private

      def get_attribute_value(parent, xpath, attribute)
        val = if xpath
                if parent.xpath(xpath).empty?
                  nil
                else
                  parent.xpath(xpath).attribute(attribute)
                end
              else
                parent.attribute(attribute)
              end
        val&.value
      end

      def create_dive(dive_xpath, computer_data)
        Dive.new(
          get_attribute_value(dive_xpath, nil, 'number').to_i,
          get_attribute_value(dive_xpath, nil, 'date'),
          get_attribute_value(dive_xpath, nil, 'time'),
          duration_in_seconds(
            strip_minutes(get_attribute_value(dive_xpath, nil, 'duration'))
          ),
          strip_percent(
            get_attribute_value(dive_xpath, 'cylinder', 'o2')
          )&.to_f,
          computer_data
        )
      end

      def create_computer_data(computer_xpath, extra_datas, samples)
        ComputerData.new(
          get_attribute_value(computer_xpath, nil, 'model'),
          get_attribute_value(computer_xpath, nil, 'deviceid'),
          get_attribute_value(computer_xpath, nil, 'diveid'),
          strip_meters(
            get_attribute_value(computer_xpath, 'depth', 'max')
          )&.to_f,
          strip_meters(
            get_attribute_value(computer_xpath, 'depth', 'mean')
          )&.to_f,
          strip_celsius(
            get_attribute_value(computer_xpath, 'temperature', 'air')
          )&.to_f,
          strip_celsius(
            get_attribute_value(computer_xpath, 'temperature', 'water')
          )&.to_f,
          strip_bar(
            get_attribute_value(computer_xpath, 'surface', 'pressure')
          )&.to_f,
          strip_g_l(
            get_attribute_value(computer_xpath, 'water', 'salinity')
          )&.to_f,
          extra_datas, samples
        )
      end

      def create_sample(sample_xpath)
        Sample.new(duration_in_seconds(
                     strip_minutes(
                       get_attribute_value(sample_xpath, nil, 'time')
                     )
                   ),
                   strip_meters(
                     get_attribute_value(sample_xpath, nil, 'depth')
                   )&.to_f,
                   strip_celsius(
                     get_attribute_value(sample_xpath, nil, 'temp')
                   )&.to_f,
                   strip_bar(
                     get_attribute_value(sample_xpath, nil, 'pressure')
                   )&.to_f,
                   duration_in_seconds(
                     strip_minutes(
                       get_attribute_value(sample_xpath, nil, 'ndl')
                     )
                   ),
                   duration_in_seconds(
                     strip_minutes(
                       get_attribute_value(sample_xpath, nil, 'tts')
                     )
                   ),
                   duration_in_seconds(
                     strip_minutes(
                       get_attribute_value(sample_xpath, nil, 'rbt')
                     )
                   ),
                   strip_percent(
                     get_attribute_value(sample_xpath, nil, 'cns')
                   )&.to_f)
      end

      def strip_minutes(string)
        strip_unit(string, 'min')
      end

      def strip_percent(string)
        strip_unit(string, '%')
      end

      def strip_celsius(string)
        strip_unit(string, 'C')
      end

      def strip_bar(string)
        strip_unit(string, 'bar')
      end

      def strip_meters(string)
        strip_unit(string, 'm')
      end

      def strip_g_l(string)
        strip_unit(string, 'g/l')
      end

      def strip_unit(string, unit)
        if string.nil?
          nil
        else
          string.slice! unit
          string.strip
        end
      end

      def duration_in_seconds(string)
        unless string.nil?
          durations = string.split(':')
          return (durations[0].strip.to_i * 60) + durations[1].strip.to_i
        end
        nil
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/ClassLength
end
