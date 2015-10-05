require 'rails_helper'

RSpec.describe Line, type: :model do

  context 'lines' do
    let!(:line) { FactoryGirl.create(:line) }

    it { should have_many(:lines_stations) }
    it { should have_many(:stations) }
    it { should have_many(:constructions) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

  end
end
