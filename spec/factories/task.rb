FactoryGirl.define do
  factory :task do
    sequence(:title)          { Faker::Name.name }
    sequence(:description)    { Faker::Lorem.sentence }
    # sequence(:deadline)       { Faker::Date.between(2019-02-07, 2019-05-07) }
    sequence(:status)         { Faker::Number.between(0, 2)}
  end
end
