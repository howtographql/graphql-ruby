require 'factory_bot'

if Vote.count.zero?
  20.times do
    FactoryBot.create :vote
  end
end
