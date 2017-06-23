FactoryGirl.define do
  factory :link do
    user
    sequence(:url) { |i| "http://example#{i}.com" }
    sequence(:description) { |i| "Link #{i} description" }
  end
end
