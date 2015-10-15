require 'rails_helper'

feature 'User deletes a reminder', %(
  As a user
  I want to cancel a reminder
  So that I don't get a reminder that I no longer want

  Acceptance Criteria
  [x] I must be on my profile page
  [x] I must be authenticated and I can only delete my reminder
  [x] I must be presented with success notice
  [x] I must not see the deleted reminder on reminder board
) do

  let(:user) { FactoryGirl.create(:user_with_reminder) }

  scenario 'user deletes a reminder' do
    reminder = user.reminders.first
    sign_in(user)
    visit user_path(user)
    click_on 'manage'
    find(".delete").click

    message = "You will no longer get a reminder for #{reminder.line.name}"
    expect(page).to have_content message
    expect(page.find('.reminder-list')).to_not have_text reminder.line.name
  end

  scenario 'user cannot delete a reminder if not authenticated' do
    reminder = user.reminders.first
    page.driver.submit :delete, reminder_path(reminder), {}

    expect(page).to have_content('need to sign in or sign up before')
  end

  scenario 'user cannot delete reminder that belongs to other user' do
    other_user = FactoryGirl.create(:user)
    sign_in(other_user)
    reminder = user.reminders.first
    page.driver.submit :delete, reminder_path(reminder), {}

    expect(page).to have_content('You have no permission to delete')
  end
end
