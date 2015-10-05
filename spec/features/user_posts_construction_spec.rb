require 'rails_helper'

feature 'User posts a new construction', %(
  As a user
  I wannt to post a construction information
  So that other users can benefit from it

  Acceptance Criteria
  [ ] I must provide which line the construction is on
  [ ] I must specify on what station does the construction start
  [ ] I must specify on what station does the construction end
  [ ] I must specify on what date the construction starts
  [ ] I must specify on what date the construction ends
  [ ] I must specify on what time the construction starts
  [ ] I must be presented with error if I fill out the form incorrectly
  [ ] I must see a success notice and be redirected to constructions index page
) do

  before do
    3.times { FactoryGirl.create(:line) }
    3.times { FactoryGirl.create(:lines_station, line: Line.first) }
  end

  scenario 'user adds a new construction' do
    line = Line.first
    first_station = line.stations.first
    last_station = line.stations.last

    visit new_construction_path
    select line.name, from: 'construction[line_id]'
    select first_station.name, from: 'construction[start_station_id]'
    select last_station.name, from: 'construction[end_station_id]'
    fill_in 'Start date', with: Date.today
    fill_in 'End date', with: Date.today + 5
    fill_in 'Start time', with: '05:00 PM'
    fill_in 'End time', with: '08:00 PM'
    click_on 'Create Construction'

    expect(page).to have_content('New construction successfully added.')
    expect(page).to have_content line.name
    expect(page).to have_content first_station.name
    expect(page).to have_content last_station.name
    expect(page).to have_content Date.today
    expect(page).to have_content Date.today + 5
    expect(page).to have_content '05:00 PM'
    expect(page).to have_content '08:00 PM'
  end

  scenario 'user filled out the form incorrectly' do
    visit new_construction_path
    click_on 'Create Construction'

    expect(page).to have_content("Line can't be blank")
    expect(page).to have_content("Start station can't be blank")
    expect(page).to have_content("End station can't be blank")
    expect(page).to have_content("Start date can't be blank")
    expect(page).to have_content("End date can't be blank")
    expect(page).to have_content("Start time can't be blank")
  end

end
