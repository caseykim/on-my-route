require 'rails_helper'

feature 'User signs in through Facebook', %(
  As a user
  I want to sign in with Facebook account
  So that I don't have to sign up
) do

  scenario 'user logs in with Facebook' do
    mock_facebook_auth!

    visit root_path
    click_link "Sign In with Facebook"

    expect(page).to have_link("Sign Out", href: destroy_user_session_path)
    expect(current_path).to eq root_path
  end

end
