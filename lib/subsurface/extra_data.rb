# frozen_string_literal: true

module Subsurface
  # Stores extra data in key value pairs
  class ExtraData
    attr_reader :key, :value
    # @param [String] key
    # @param [String] value
    def initialize(key, value)
      @key = key
      @value = value
    end
  end
end