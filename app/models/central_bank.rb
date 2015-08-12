class CentralBank < ActiveRecord::Base

  scope :latest,    -> { order(:id) }
  scope :in_ticker, -> { where(in_ticker: true) }

  validates :bank_name, :bank_link, :policy_target, :current_settings, :change, :next_policy_announcement, :change_expected,
            :report_name, :report_link,
            presence: true, length: { maximum: 255 }

  validates :changed_at, presence: true
end
