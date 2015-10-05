require 'rails_helper'

RSpec.describe Line, type: :model do

  context 'lines' do
    let!(:lines_station) { FactoryGirl.create :lines_station }
    let!(:line) { lines_station.line }

    it { should have_many(:lines_stations) }
    it { should have_many(:stations).through(:lines_stations) }
    it { should have_many(:constructions) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

  end
end
