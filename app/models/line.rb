class Line < ActiveRecord::Base
  has_many :lines_stations
  has_many :stations, through: :lines_stations
  has_many :constructions

  validates :name, presence: true, uniqueness: true
end
