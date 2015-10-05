require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :line do
    sequence(:name) { |n| "line #{n}" }
  end

  factory :station do
    sequence(:name) { |n| "station #{n}" }
  end

  factory :line_with_station, parent: :line do
    ignore do
      station { FactoryGirl.create(:station) }
    end

    after(:create) do |line, evaluator|
      line.stations << evaluator.station
    end
  end

  factory :lines_station do
    line
    station
  end

  factory :construction do
    line
    start_station
    end_station
    start_date { Date.today }
    end_date { Date.today + 3 }
    start_time { Time.now }
  end
end
