# frozen_string_literal: true

module Subsurface
  # noinspection RubyTooManyInstanceVariablesInspection
  # Stores the computer data for each computer in the dive
  class ComputerData
    # TODO: Handle events
    attr_reader :model, :device_id, :dive_id, :max_depth, :mean_depth,
                :air_temp, :water_temp, :surface_pressure,
                :salinity, :extra_datas, :samples
    # rubocop:disable Metrics/ParameterLists, Metrics/MethodLength
    # @param [String] model
    # @param [String] device_id
    # @param [String] dive_id
    # @param [Integer] max_depth in meters
    # @param [Integer] mean_depth in meters
    # @param [Integer] air_temp in C
    # @param [Integer] water_temp in C
    # @param [Integer] surface_pressure in bar
    # @param [Integer] salinity in g/l
    # @param [ExtraData] extra_datas
    # @param [Sample] samples
    # @return [ComputerData]
    def initialize(model, device_id, dive_id, max_depth, mean_depth, air_temp,
                   water_temp, surface_pressure, salinity, extra_datas, samples)
      @model = model
      @device_id = device_id
      @dive_id = dive_id
      @max_depth = max_depth
      @mean_depth = mean_depth
      @air_temp = air_temp
      @water_temp = water_temp
      @surface_pressure = surface_pressure
      @salinity = salinity
      @extra_datas = extra_datas
      @samples = samples
    end
    # rubocop:enable Metrics/ParameterLists, Metrics/MethodLength
  end
end