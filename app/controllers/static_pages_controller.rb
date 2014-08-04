class StaticPagesController < ApplicationController
  def show
    render status: 200, file: 'public/index.html'
  end
end
