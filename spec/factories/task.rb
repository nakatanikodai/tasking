FactoryBot.define do
  factory :task do
    name {'テストを書く'}
    description{'RSpec & Capybara & Factoryを準備する'}
    user
  end
end