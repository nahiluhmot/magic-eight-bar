# This controller just renders index.html. The purpose of this controller is to
# allow the frontend to handle the user-facing routes.
class StaticPagesController < ApplicationController
  # Render the public page.
  #
  # Sample:
  #   Request:
  #     path: /about
  #     method: GET
  #   Response:
  #     content: text/html
  #     status: 200
  def show
    render status: 200, file: 'public/index.html'
  end
end
