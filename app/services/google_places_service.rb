# This module searches the google places api for bars in boston and saves them to the database.
module GooglePlacesService
  module_function

  # Global list of coordinates for places around Boston.
  NORTH = BigDecimal.new('42.358084')
  WEST = BigDecimal.new('-71.063600')

  # Save all of the bars given by the Google Places API.
  def save_bars
    if ENV['GOOGLE_PLACES_API_KEY'].nil?
      raise "Please set ENV['GOOGLE_PLACES_API_KEY'] to run this code"
    else
      bars_with_info.lazy.map { |bar| save_bar(bar) }.force
    end
  end

  # Save a single bar.
  def save_bar(bar)
    Bar.create!(
      name: bar.name,
      address: bar.formatted_address,
      place_id: bar.place_id,
      lat: bar.geometry.location.lat,
      lon: bar.geometry.location.lng,
      website: bar.website
    )
    logger.info("Created bar with name: #{bar.name}")
  rescue => ex
    logger.warn("Could not create bar (#{bar}) due to: #{ex}")
  end

  # Get all of the bars with their info.
  def bars_with_info
    bars.lazy.map { |bar| client.details(placeid: bar.place_id) }
  end

  # Retrieve 200 bars from boston.
  def bars(&block)
    return enum_for(:bars) if block.nil?

    range = [
      BigDecimal.new('0.025'),
      BigDecimal.new('0'),
      BigDecimal.new('-0.025')
    ]
    range.each do |delta_north|
      range.each do |delta_west|
        coord = [NORTH + delta_north, WEST + delta_west].join(',')
        client.search.radar(coord, radius: 2500, types: 'bar').each(&block)
      end
    end
  end

  # The rails logger.
  def logger
    Rails.logger
  end

  # This is the client that interacts with the Google Places API
  def client
    @client ||= PlacesAPI.new(ENV['GOOGLE_PLACES_API_KEY'])
  end
end
