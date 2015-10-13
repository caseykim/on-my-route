require 'rails_helper'

feature 'User requests a construction reminder', %(
  As a user
  I want to sign up for a construction reminder
  So that I can schedule my trip around the construction

  Acceptance Criteria
  [x] I must be authenticated before requesting a reminder
  [x] I must be presented with success notice after a successful setup
  [x] I must provide name and phone number
  [x] I must be presented with errors if I fill out the form incorrectly
) do

  let(:user) { FactoryGirl.create(:user) }
  let(:line) { FactoryGirl.create(:line) }

  before do
    FactoryGirl.create(:construction, line: line)
    time = 30.minutes.from_now
    FactoryGirl.create(:construction, line: line, start_time: time)
  end

  scenario 'User signs up for a construction reminder' do
    sign_in(user)
    visit user_path(user)
    click_on 'Set a reminder'
    fill_in 'Name', with: 'Launcher Casey'
    fill_in 'Phone number', with: '+17143377178'
    select line.name
    click_on 'Create Reminder'

    expect(page).to have_content('Reminder set up successfully.')
    expect(page).to have_content line.name
  end

  scenario 'User must be authenticated' do
    visit user_path(user)

    expect(page).to have_content('need to sign in or sign up before')
    expect(current_path).to eq new_user_session_path
  end

  scenario 'User has no access to profile of other user' do
    other_user = FactoryGirl.create(:user)
    sign_in(other_user)
    visit user_path(user)

    expect(page).to have_content('Access Denied')
    expect(current_path).to eq constructions_path
  end

  scenario 'User signs up for a construction reminder' do
    sign_in(user)
    visit user_path(user)
    click_on 'Set a reminder'
    fill_in 'Name', with: ''
    fill_in 'Phone number', with: ''
    click_on 'Create Reminder'

    expect(page).to have_content("User missing name and/or phone number")
    expect(page).to have_content("Line can't be blank")
  end
end
