class Construction < ActiveRecord::Base
  belongs_to :user
  belongs_to :line
  belongs_to :start_station, class_name: 'Station'
  belongs_to :end_station, class_name: 'Station'
  has_many :station_constructions
  has_many :stations, through: :station_constructions


  validates :line, presence: true
  validates :start_station, presence: true
  validates :end_station, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  validates :start_time, presence: true
  validate :end_time_after_start_time


  scope :search, -> (station_name) {
    joins(:station_constructions)
    .joins(:stations)
    .merge(Station.by_name(station_name))
    .uniq
  }
  after_create :create_station_constructions



  private

  def affected_stations
    stations = line.lines_stations
    start_i = stations.find_by(station: start_station).station_sequence
    end_i = stations.find_by(station: end_station).station_sequence
    range = start_i <= end_i ? start_i..end_i : end_i..start_i
    stations.where(
      station_sequence: range
    ).joins(:station).all.map(&:station)
  end

  def create_station_constructions
    affected_stations.each do |station|
      StationConstruction.create(station: station, construction: self)
    end
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "can't be before the start date")
    end
  end

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, "can't be before the start time")
    end
  end
end
