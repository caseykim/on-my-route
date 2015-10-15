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
    line
    association :start_station, factory: :station
    association :end_station, factory: :station
    start_date { Date.today }
    end_date { Date.today + 3 }
    start_time { Time.now }
  end
end
