require 'rails_helper'

RSpec.describe Station, type: :model do

  context 'stations' do
    let!(:station) { FactoryGirl.create(:station) }

    it { should have_many(:lines_stations) }
    it { should have_many(:lines).through(:lines_stations) }
    it { should have_many(:constructions) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

  end
end
