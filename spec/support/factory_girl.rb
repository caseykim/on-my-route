require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    name 'Test User'
    phone_number '+11234567890'

    factory :user_with_reminder do
      after(:create) do |user|
        create(:reminder, user: user)
      end
    end
  end

  factory :reminder do
    user
    line
  end

  factory :line do
    sequence(:name) { |n| "line #{n}" }

    factory :line_with_stations do
      after(:create) do |line|
        2.times { FactoryGirl.create(:lines_station, line: line) }
      end
    end
  end

  factory :station do
    sequence(:name) { |n| "station #{n}" }
  end

  factory :lines_station do
    line
    station
    sequence(:station_sequence) { |n| n }
  end

  factory :construction do
    before(:create) do |construction|
      line = FactoryGirl.create(:line_with_stations)
      construction.start_station = line.stations.first
      construction.end_station = line.stations.last
      construction.line = line
    end
    start_date { Date.today }
    end_date { Date.today + 3 }
    start_time { Time.now }
  end
end
