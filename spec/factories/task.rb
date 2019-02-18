FactoryGirl.define do

  factory :task do
    sequence(:title) { |n| "task#{n}"}
    sequence(:description) { |n| "descriiption#{n}"}
    sequence(:deadline) { |n| "#{Date.current + n.days}"}
    sequence(:created_at) { |n| "#{Time.current} - #{n.days}"}
    association :user, factory: :user
  end

end
