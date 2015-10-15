class StationConstruction < ActiveRecord::Base
  belongs_to :station
  belongs_to :construction

  validates :station, presence: true
  validates :construction, presence: true
end
