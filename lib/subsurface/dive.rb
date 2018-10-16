# frozen_string_literal: true

# Dive is the model that contains all the information for each dive
class Dive
  attr_reader :number, :date, :time, :duration, :o2_percent, :computer_data
  # rubocop:disable Metrics/ParameterLists
  # @param [Integer] number
  # @param [String] date
  # @param [String] time
  # @param [Integer] duration in seconds
  # @param [Integer] o2_percent=
  # @param [ComputerData] computer_data
  # @return [Dive]
  def initialize(number, date, time, duration, o2_percent, computer_data)
    @number = number
    @date = date
    @time = time
    @duration = duration
    @o2_percent = o2_percent
    @computer_data = computer_data
  end
  # rubocop:enable Metrics/ParameterLists
end