# This module handles the Bar's lifecyle.
module BarsService
  module_function

  # Get a list of every bar.
  def all_bars
    Bar.all.map(&:attributes)
  end

  # Get a bar by its place_id.
  def get_bar(place_id)
    Bar.where(place_id: place_id).first.try(&:attributes)
  end

  # Test if a bar exists by its place_id.
  def exists?(place_id)
    Bar.exists?(place_id: place_id)
  end

  # Create a bar.
  def create_bar(attrs = {})
    Bar.create!(attrs).attributes
  end

  # Destroy a bar by its place id.
  def destroy_bar(place_id)
    Bar.where(place_id: place_id).destroy_all
    nil
  end
end
