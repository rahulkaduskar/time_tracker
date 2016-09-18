class AnalyticsController < ApplicationController

  def index
  	@avg_time, @confidance_time = UserArrival.calculate_avg_confidance
  end
end