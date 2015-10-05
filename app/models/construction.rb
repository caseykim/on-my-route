class Construction < ActiveRecord::Base
  belongs_to :line
  belongs_to :start_station, class_name: 'Station'
  belongs_to :end_station, class_name: 'Station'

  validates :line, presence: true
  validates :start_station, presence: true
  validates :end_station, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  validates :start_time, presence: true
  validate :end_time_after_start_time

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
