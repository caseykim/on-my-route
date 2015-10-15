require 'rails_helper'

RSpec.describe Construction, type: :model do

  context 'constructions' do

    let!(:construction) { FactoryGirl.create(:construction) }

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
