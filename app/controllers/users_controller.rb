# This controller handles user lifecycle.
class UsersController < ApplicationController
  # Return all of the Users.
  def index
    logger.debug('Listing all users')
    render status: 200, json: UsersService.all_users.to_json
  rescue => ex
    logger.error("Could not find users user due to #{ex.class}:#{ex.message}")
    render status: 500, body: nil
  end

  # Create a new user.
  def create
    logger.debug('Creating new user')
    user = UsersService.create_user
    logger.debug("Created new user: #{user}")
    cookies[:id] = user['session']
    render status: 201, json: user.to_json
  rescue => ex
    logger.error("Could not create user due to #{ex.class}:#{ex.message}")
    render status: 500, body: nil
  end

  # Get the currently authenticated user.
  def show
    logger.debug("Looking up user with session: #{params[:id]}")
    if (user = UsersService.get_user(params[:id])).nil?
      logger.error("No user found for #{params[:id]}")
      render status: 404, body: nil
    else
      logger.info("Found user for session #{params[:id]}: #{user}")
      render status: 200, json: user.to_json
    end
  end
end
