class Event < ActiveRecord::Base
  belongs_to :country
  scope :upcoming,  -> { where('date > ?', Time.zone.now).order(:date) }
  scope :in_ticker, -> { where(in_ticker: true) }

  validates :title, :country_id, :date, :time_local, :time_gmt, presence: true
  validates :title, :data_for, length: { maximum: 255 }
end