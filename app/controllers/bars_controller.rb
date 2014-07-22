# This controller handles bar lifecycle.
class BarsController < ApplicationController
  # Return all of the bars.
  def index
    logger.debug('Listing all bars')
    render status: 200, json: BarsService.all_bars.to_json
  rescue => ex
    logger.error("Could not find bars due to #{ex.class}:#{ex.message}")
    render status: 500, body: nil
  end
 
  # Create a new bar.
  def create
    logger.debug('Creating new bar')
    bar = BarsService.create_bar(params.permit(:place_id, :name, :address))
    logger.debug("Created new bar: #{bar}")
    render status: 201, json: bar.to_json
  rescue => ex
    logger.error("Could not create bar due to #{ex.class}:#{ex.message}")
    render status: 400, body: nil
  end

  # Get the a bar by its place_id.
  def show
    logger.debug("Looking up bar with place_id: #{params[:id]}")
    if (bar = BarsService.get_bar(params[:id])).nil?
      logger.error("No bar found for #{params[:id]}")
      render status: 404, body: nil
    else
      logger.info("Found bar for place_id #{params[:id]}: #{bar}")
      render status: 200, json: bar.to_json
    end
  end

  # Delete a bar by its place_id.
  def destroy
    if params[:id].nil? || !BarsService.exists?(params[:id])
      render status: 400, body: nil
    else
      logger.debug("Deleting bar with place_id: #{params[:id]}")
      BarsService.destroy_bar(params[:id])
      render status: 204, body: nil
    end
  end
end
