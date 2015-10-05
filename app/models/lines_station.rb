class LinesStation < ActiveRecord::Base
  belongs_to :line
  belongs_to :station

  validates :line, presence: true
  validates :station, presence: true
  validates :station, uniqueness: { scope: :line }
  validates :station_sequence, presence: true
end
