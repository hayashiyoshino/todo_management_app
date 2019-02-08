FactoryGirl.define do
  factory :task do
    sequence(:title)          { Faker::Name.name }
    sequence(:description)    { Faker::Lorem.sentence }
    sequence(:status)         { Faker::Number.between(0, 2)}
    sequence(:user_id)        { Faker::Number.between(1, 2)}
  end
end
