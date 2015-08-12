class Link < ActiveRecord::Base
  validates :title, :url, presence: true
  validates :title, length: { maximum: 255 }
  validates :description, length: { maximum: 1_000 }
  validates_presence_of :published_at

  scope :latest,      -> { order('published_at DESC') }
  scope :in_ticker,   -> { where(in_ticker: true) }


  def published_at
    super || created_at
  end
end