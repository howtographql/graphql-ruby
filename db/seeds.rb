require 'factory_girl'

if Vote.count.zero?
  20.times do
    FactoryGirl.create :vote
  end
end
