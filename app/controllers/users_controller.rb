# This controller handles user lifecycle.
class UsersController < ApplicationController
  # Create a new user.
  #
  # Sample:
  #   Request:
  #     path: /api/users/
  #     method: POST
  #     params: {}
  #   Response:
  #     content: application/json
  #     status: 200
  #     body:
  #       {
  #         "id": 30,
  #         "session": "79242894734700608109366522220280"
  #       }
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
  #
  # Sample:
  #   Request:
  #     path: /api/users/valid
  #     method: GET
  #     params: {}
  #     cookies:
  #       id: 79242894734700608109366522220280
  #   Response:
  #     content: application/json
  #     status: 200
  def valid?
    logger.debug("Testing if user with cookie #{cookies[:id]} is a valid user")
    if user = User.where(session: cookies[:id]).first
      logger.debug("User is valid: #{user.attributes}")
      render status: 200, body: nil
    else
      logger.debug('User is invalid')
      render status: 404, body: nil
    end
  end
end
