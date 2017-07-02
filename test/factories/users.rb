FactoryGirl.define do
  factory :user do
    sequence(:name) { |i| "User #{i}" }
    sequence(:email) { |i| "user#{i}@example.com" }
    password { '123456' }
  end
end
