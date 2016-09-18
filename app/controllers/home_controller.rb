class HomeController < ApplicationController

  def index
  	@user_arrival = UserArrival.new
  end
end