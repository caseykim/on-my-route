require 'rails_helper'

feature 'User deletes a construction posting', %(
  As a user
  I want to delete a construction information
  So that I can delete wrong or irrelevant construction posting

  Acceptance Criteria
  [x] I must be the user who post the constuction originally
  [x] Other users cannot delete my constuction posting
  [x] I must be authenticated in order to delete a posting
  [x] I must see a confirmation and be redirected to constructions path
) do

  let(:user) { FactoryGirl.create(:user) }
  let(:construction) { FactoryGirl.create(:construction, user: user) }

  scenario 'user cannot delete construction if not signed in' do
    page.driver.submit :delete, construction_path(construction), {}

    expect(page).to have_content('need to sign in or sign up before')
    expect(current_path).to eq new_user_session_path
  end

  scenario 'user cannot delete construction posting of others' do
    other_user = FactoryGirl.create(:user)
    sign_in(other_user)
    page.driver.submit :delete, construction_path(construction), {}

    expect(page).to have_content('You have no permission to edit this posting')
    expect(current_path).to eq constructions_path
  end

  scenario 'user deletes construction posting' do
    sign_in(user)
    construction
    visit constructions_path

    expect { click_link('delete') }.to change(Construction, :count).by(-1)

    Construction.all.each do |construction|
      expect(page).to have_content construction.line.name
      expect(page).to have_content construction.start_station.name
      expect(page).to have_content construction.end_station.name
      expect(page).to have_content construction.start_date
      expect(page).to have_content construction.end_date
      expect(page).to have_content construction.start_time
    end
  end

end
