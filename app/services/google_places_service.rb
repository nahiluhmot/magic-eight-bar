# This module searches the google places api for bars in boston and saves them to the database.
module GooglePlacesService
  module_function

  def save_bars
    if ENV['GOOGLE_PLACES_API_KEY'].nil?
      raise "Please set ENV['GOOGLE_PLACES_API_KEY'] to run this code"
    else
      bars_with_info.lazy.map { |bar| save_bar(bar) }.force
    end
  end

  def save_bar(bar)
    Bar.create!(
      name: bar.name,
      address: bar.formatted_address,
      place_id: bar.place_id
    )
    logger.info("Created bar with name: #{bar.name}")
  rescue => ex
    logger.warn("Could not create bar (#{bar}) due to: #{ex}")
  end

  def bars_with_info
    bars.lazy.map { |bar| client.details(placeid: bar.place_id) }
  end

  def bars
    client.search.radar('42.3581,-71.0636', radius: 5000, types: 'bar')
  end

  def logger
    Rails.logger
  end

  def client
    @client ||= PlacesAPI.new(ENV['GOOGLE_PLACES_API_KEY'])
  end
end
