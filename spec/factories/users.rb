FactoryGirl.define do
  factory :user do
    name "Hayashi"
    sequence(:email) { |n| "tester#{n}@example.com" }
    password "11111111"
    password_confirmation "11111111"
    association :group, factory: :group
  end
end
