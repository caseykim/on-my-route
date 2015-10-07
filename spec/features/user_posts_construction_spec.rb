require 'rails_helper'

feature 'User posts a new construction', %(
  As a user
  I wannt to post a construction information
  So that other users can benefit from it

  Acceptance Criteria
  [x] I must provide which line the construction is on
  [x] I must specify on what station does the construction start
  [x] I must specify on what station does the construction end
  [x] I must specify on what date the construction starts
  [x] I must specify on what date the construction ends
  [x] I must specify on what time the construction starts
  [x] I must be presented with error if I fill out the form incorrectly
  [x] I must see a success notice and be redirected to constructions index page
) do

  before do
    3.times { FactoryGirl.create(:line) }
    3.times { FactoryGirl.create(:lines_station, line: Line.first) }
  end

  let(:user) { FactoryGirl.create(:user) }

  scenario 'user cannot add a new construction if not signed in' do
    line = Line.first
    first_station = line.stations.first
    last_station = line.stations.last

    visit new_construction_path

    expect(page).to have_content('You need to sign in or sign up before continuing.')
    expect(current_path).to eq new_user_session_path
  end

  scenario 'user adds a new construction' do
    line = Line.first
    first_station = line.stations.first
    last_station = line.stations.last
    sign_in user

    visit new_construction_path
    select line.name, from: 'construction[line_id]'
    select first_station.name, from: 'construction[start_station_id]'
    select last_station.name, from: 'construction[end_station_id]'
    fill_in 'Start date', with: Date.today
    fill_in 'End date', with: Date.today + 5
    fill_in 'Start time', with: '05:00 PM'
    fill_in 'End time', with: '08:00 PM'
    click_on 'Create Construction'

    expect(page).to have_content('New construction added successfully.')
    expect(page).to have_content line.name
    expect(page).to have_content first_station.name
    expect(page).to have_content last_station.name
    expect(page).to have_content Date.today
    expect(page).to have_content Date.today + 5
    expect(page).to have_content '05:00 PM'
    expect(page).to have_content '08:00 PM'

    Construction.all.each do |construction|
      expect(page).to have_content construction.line.name
      expect(page).to have_content construction.start_station.name
      expect(page).to have_content construction.end_station.name
      expect(page).to have_content construction.start_date
      expect(page).to have_content construction.end_date
      expect(page).to have_content construction.start_time
    end
  end

  scenario 'user filled out the form incorrectly' do
    sign_in user
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
