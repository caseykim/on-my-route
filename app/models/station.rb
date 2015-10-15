class Station < ActiveRecord::Base
  has_many :lines_stations
  has_many :lines, through: :lines_stations
  has_many :constructions, foreign_key: 'start_station_id'
  has_many :constructions, foreign_key: 'end_station_id'

  has_many :station_constructions
  has_many :ongoing_constructions, source: :construction, through: :station_constructions


  validates :name, presence: true, uniqueness: true
  scope :by_name, -> (name) { where('name ilike ?', "%#{name}%") }
end
