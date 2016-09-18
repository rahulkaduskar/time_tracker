class UserArrivalsController < ApplicationController

  def index
  	@user_arrivals = UserArrival.all
  	@avg_time, @confidance_time = UserArrival.calculate_avg_confidance
  end

  def create
  	username = params[:username]
  	@user_arrival = UserArrival.new({username: username})
  	if @user_arrival.save
  	  redirect_to root_path, notice: 'User arrival successfully registered'
  	else
      render template: "home/index"
  	end
  end
end