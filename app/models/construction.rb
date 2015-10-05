class Construction < ActiveRecord::Base
  belongs_to :line
  belongs_to :start_station, class_name: 'Station'
  belongs_to :end_station, class_name: 'Station'

  validates :line, presence: true
  validates :start_station, presence: true
  validates :end_station, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_time, presence: true
end
