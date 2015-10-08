require 'rails_helper'

feature 'User edits a construction posting', %(
  As a user
  I want to edit a construction information
  So that I can correct or update construction information

  Acceptance Criteria
  [x] I must be the user who post the constuction originally
  [x] Other users cannot edit my constuction posting
  [x] I must be authenticated in order to make changes
  [x] I must be able to change the line
  [x] I must be able to change the start station
  [x] I must be able to change the end station
  [x] I must be able to change the start date
  [x] I must be able to change the end date
  [x] I must be able to change the start time
  [x] I must see a confirmation and be redirected to constructions path
  [ ] I must see an error if I complete the form incorrectly
  [x] I can optionally add or delete the description
) do

  let(:user) { FactoryGirl.create(:user) }
  let(:construction) { FactoryGirl.create(:construction, user: user) }

  before do
    2.times { FactoryGirl.create(:line) }
    3.times { FactoryGirl.create(:lines_station, line: Line.first) }
  end

  scenario 'user cannot edit construction if not signed in' do
    visit edit_construction_path(construction)

    expect(page).to have_content('need to sign in or sign up before')
    expect(current_path).to eq new_user_session_path
  end

  scenario 'user cannot edit construction posting of others' do
    other_user = FactoryGirl.create(:user)
    sign_in(other_user)
    visit edit_construction_path(construction)

    expect(page).to have_content('You have no permission to edit this posting')
    expect(current_path).to eq constructions_path
  end

  scenario 'user edits construction posting' do
    sign_in(user)
    visit edit_construction_path(construction)
    line = Line.first

    select line.name, from: 'construction[line_id]'
    select line.stations[1].name, from: 'construction[start_station_id]'
    select line.stations[2].name, from: 'construction[end_station_id]'
    fill_in 'Start date', with: Date.today + 7
    fill_in 'End date', with: Date.today + 10
    fill_in 'Start time', with: '08:45 PM'
    fill_in 'End time', with: '10:00 PM'
    fill_in 'Description', with: 'updated information'
    click_on 'Update Construction'

    expect(page).to have_content('Construction updated successfully.')
    expect(page).to have_content line.name
    expect(page).to have_content line.stations[1].name
    expect(page).to have_content line.stations[2].name
    expect(page).to have_content Date.today + 7
    expect(page).to have_content Date.today + 10
    expect(page).to have_content '08:45 PM'
    expect(page).to have_content '10:00 PM'
    expect(page).to have_content 'updated information'

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
    sign_in(user)
    visit edit_construction_path(construction)

    fill_in 'Start time', with: '08:45 PM'
    fill_in 'End time', with: '08:00 PM'
    fill_in 'Description', with: ''
    click_on 'Update Construction'

    expect(page).to have_content("End time can't be before the start time")
  end

end
