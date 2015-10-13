require 'rails_helper'

feature 'User searches for construction by station name', %(
  As a user
  I want to search for constructions by station name
  So that I can view all constructions that affect the station of my interest

  Acceptance Criteria
  [x] I must provide station name
  [x] I must be able to see all constructions in that station
) do

  let(:station) { FactoryGirl.create(:station) }

  before do
    FactoryGirl.create(:construction, start_station: station)
    FactoryGirl.create(:construction, end_station: station)
  end

  scenario 'User searches for constructions by station name' do
    visit constructions_path
    fill_in 'station', with: station.name

    expect(page).to have_css('.construction', count: 2)
  end

  scenario 'User does not see constructions on other stations' do
    other_station = FactoryGirl.create(:station)
    visit constructions_path
    fill_in 'station', with: station.name

    expect(page).to_not have_content other_station.name
  end
end
