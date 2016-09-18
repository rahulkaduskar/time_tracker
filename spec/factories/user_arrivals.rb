FactoryGirl.define do
  factory :user_arrival do
    arrived_at Time.now
    association :user, :factory=> :user
  end
end