FactoryGirl.define do
  factory :user do
    name "Hayashi"
    sequence(:email) { |n| "tester#{n}@example.com" }
    password_digest "11111111"
  end
end
