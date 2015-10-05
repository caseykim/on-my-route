class Station < ActiveRecord::Base
  has_many :lines_stations
  has_many :lines, through: :lines_stations
  has_many :constructions, foreign_key: 'start_station_id'
  has_many :constructions, foreign_key: 'end_station_id'

  validates :name, presence: true, uniqueness: true
end
