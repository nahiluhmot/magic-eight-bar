# This controller handles bar lifecycle.
class BarsController < ApplicationController
  # Return all of the bars.
  def index
    logger.debug('Listing all bars')
    render status: 200, json: Bar.all.to_json
  rescue => ex
    logger.error("Could not list bars due to #{ex.class}:#{ex.message}")
    render status: 500, body: nil
  end
end
