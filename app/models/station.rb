class Station < ActiveRecord::Base
  has_many :lines_stations
  has_many :lines, through: :lines_stations
  has_many :station_constructions
  has_many :constructions, through: :station_constructions


  validates :name, presence: true, uniqueness: true
  scope :by_name, -> (name) { where('name ilike ?', "%#{name}%") }
end
