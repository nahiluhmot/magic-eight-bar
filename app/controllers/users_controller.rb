# This controller handles user lifecycle.
class UsersController < ApplicationController
  # Return all of the Users.
  def index
    logger.debug('Listing all users')
    render status: 200, json: UsersService.all_users.to_json
  rescue => ex
    logger.error("Could not create user due to #{ex.class}:#{ex.message}")
    render status: 500
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
    render status: 500
  end

  # Get the currently authenticated user.
  def show
    if (user = UsersService.get_user(params[:id])).nil?
      render status: 404, body: nil
    else
      render status: 200, json: user.to_json
    end
  end

end
