# frozen_string_literal: true

module Subsurface
  # TODO: Stops, o2sensors, set_point, heartbeat, bearing, in_deco
  # Stores the data in each sample
  class Sample
    attr_reader :time, :depth, :temp, :pressure, :ndl, :tts, :rbt, :cns
    # rubocop:disable Metrics/ParameterLists
    # @param [String] time
    # @param [Integer] depth
    # @param [Integer] temp
    # @param [Integer] pressure
    # @param [Integer] ndl
    # @param [Integer] tts
    # @param [Integer] rbt
    # @param [Integer] cns
    # @return [Sample]
    def initialize(time, depth, temp, pressure, ndl, tts, rbt, cns)
      @time = time
      @depth = depth
      @temp = temp
      @pressure = pressure
      @ndl = ndl
      @tts = tts
      @rbt = rbt
      @cns = cns
    end
    # rubocop:enable Metrics/ParameterLists
  end
end