# This controller handles user lifecycle.
class UsersController < ApplicationController
  # Create a new user.
  def create
    logger.debug('Creating new user')
    user = User.create!
    logger.debug("Created new user: #{user}")
    cookies[:id] = user['session']
    render status: 201, json: user.to_json
  rescue => ex
    logger.error("Could not create user due to #{ex.class}:#{ex.message}")
    render status: 500, body: 'Internal error creating user'
  end

  # Test if the logged in user is valid.
  def valid?
    logger.debug("Testing if user with cookie #{cookies[:id]} is a valid user")
    if user = User.where(session: cookies[:id]).first
      logger.debug("User is valid: #{user.attributes}")
      render status: 200, body: nil
    else
      logger.debug('User is invalid')
      render status: 400, body: nil
    end
  end
end
