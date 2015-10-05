class Station < ActiveRecord::Base
  has_many :lines_stations
  has_many :lines, through: :lines_stations
  has_many :constructions

  validates :name, presence: true, uniqueness: true
end
