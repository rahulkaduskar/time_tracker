class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @avg_time, @confidance_time = UserArrival.calculate_avg_confidance(@user.id)
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  	  redirect_to @user, notice: "User was successfully created"
  	else
  	  render :new
  	end

  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username)
    end

end