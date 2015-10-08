require 'rails_helper'

feature 'User views constructions by line', %(
  As a user
  I want to view constructions by line
  So that I can only see constructions on my route

  Acceptance Criteria
  [x] I must see constructions on the current line
  [x] I must not see constructions affecting other line
) do

  let(:line) { FactoryGirl.create(:line) }

  before do
    3.times { FactoryGirl.create(:construction, line: line) }
  end

  scenario 'user chooses line to see constructions' do
    visit line_constructions_path(line)

    line.constructions.each do |construction|
      expect(page).to have_content construction.start_station.name
      expect(page).to have_content construction.end_station.name
      expect(page).to have_content construction.start_date
      expect(page).to have_content construction.end_date
      expect(page).to have_content construction.start_time
      expect(page).to have_css "##{construction.id}"
    end
  end

  scenario 'user only sees constructions on the line they selected' do
    other_line = FactoryGirl.create(:line)
    other_constructions = FactoryGirl.create(:construction, line: other_line)
    visit line_constructions_path(line)

    line.constructions.each do |construction|
      expect(page).to have_css "##{construction.id}"
    end

    other_line.constructions.each do |construction|
      expect(page).to_not have_css "##{construction.id}"
    end
  end

end
