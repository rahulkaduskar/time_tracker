# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
(1..10).each do |n|
  user = User.new(username: "user#{n}")
  user.save!
end
User.all.each do |user|
  (0..3).each do |n|
    user_arrival = UserArrival.new()
    user_arrival.user = user
    user_arrival.save(:validate => false)
    time = (Time.now - (n-1).days - rand(200).minutes)
    user_arrival.update_attribute(:arrived_at, time )
 end
end