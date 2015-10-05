class LinesStation < ActiveRecord::Base
  belongs_to :line, presence: true
  belongs_to :station, presence: true
  
  validates :station, uniqueness: { scope: :line }
  validates :station_sequence, presence: true
end
