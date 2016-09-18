class UserArrival < ActiveRecord::Base

  INTIME =  "10:00:00AM".in_time_zone("Mumbai")

  CONFIDANCE_INTERVAL_PERCENT = 95

  attr_accessor :username

  before_create :set_params

  validates :user_id, presence: { message: "User not present. Please specify correct username"}

  validate :check_arrival_exists, on: :create

  belongs_to :user

  def initialize(args=nil)
    super
    user = args.blank? ? nil : User.where(["lower(username) = ? ", args[:username].downcase ]).first
    if user.present?
      self.user_id = user.id 
    end 
  end

  def is_arrived_late?
    self.arrived_at.strftime("%H%M%S") > INTIME.utc.strftime("%H%M%S")
  end

  def set_params
  	self.arrived_at = Time.now
  end

  def check_arrival_exists

  	if UserArrival.where(["date(arrived_at) = ? and user_id = ?", Date.today , self.user_id]).count > 0
      errors.add(:user_id, "Arrival already registered for #{self.username}")
  	end
  end

  def self.calculate_avg_confidance(user_id = nil)
  	values = UserArrival.select("STDDEV(Time(arrived_at)) as sdt, avg(Time_to_sec(arrived_at)) average_time, sqrt(count(*)) as sqrt_count")
    values = values.where(user_id: user_id)  unless user_id.blank?
    binding.pry
    values = values.first
    if values['average_time'].present? && values['sdt'].present?
      avg_time = values['average_time']
      confidance_time = avg_time + ((1 - CONFIDANCE_INTERVAL_PERCENT/100) * (values['sdt']/values['sqrt_count']))
      return Time.zone.at(avg_time), Time.zone.at(confidance_time)
    else
     return  nil, nil
    end
  end
end