require 'rails_helper'

RSpec.describe Construction, type: :model do

  context 'constructions' do

    let(:line) { FactoryGirl.create(:line) }
    let(:lines_station_first) { FactoryGirl.create(:lines_station, line: line)}
    let(:lines_station_second) { FactoryGirl.create(:lines_station, line: line)}
    let(:start_station) { lines_station_first.station }
    let(:end_station) { lines_station_second.station }
    let!(:construction) { FactoryGirl.create(:construction, line: line, start_station: start_station, end_station: end_station) }

    it { should belong_to(:line) }
    it { should belong_to(:start_station) }
    it { should belong_to(:end_station) }

    it { should validate_presence_of(:line) }
    it { should validate_presence_of(:start_station) }
    it { should validate_presence_of(:end_station) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:start_time) }

  end
end
