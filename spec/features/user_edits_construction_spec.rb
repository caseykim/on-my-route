require 'rails_helper'

feature 'User edits a construction posting', %(
  As a user
  I want to edit a construction information
  So that I can correct or update construction information

  Acceptance Criteria
  [ ] I must be the user who post the constuction originally
  [ ] Other users cannot edit my constuction posting
  [ ] I must be authenticated in order to make changes
  [ ] I must be able to change the line
  [ ] I must be able to change the start station
  [ ] I must be able to change the end station
  [ ] I must be able to change the start date
  [ ] I must be able to change the end date
  [ ] I must be able to change the start time
  [ ] I must see a confirmation and be redirected to constructions path
  [ ] I must see an error if I complete the form incorrectly
  [ ] I can optionally add or delete the description
) do

  let(:user) { FactoryGirl.create(:user) }
  let(:construction) { FactoryGirl.create(:construction, user: user) }


  scenario 'user cannot edit construction if not signed in' do
    visit edit_construction_path(construction)

    expect(page).to have_content('need to sign in or sign up before')
    expect(current_path).to eq new_user_session_path
  end

  xscenario 'user adds a new construction' do
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

  xscenario 'user filled out the form incorrectly' do
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
