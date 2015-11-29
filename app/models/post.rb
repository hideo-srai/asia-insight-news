class Post < ActiveRecord::Base
  include Concerns::Sluggable
  include RankedModel
  acts_as_taggable
  self.per_page = 20

  ranks :rank
  is_impressionable counter_cache: true, column_name: :views

  enum visibility: { green: 'green', yellow: 'yellow', red: 'red', silver: 'silver' }

  before_save :set_published_at

  has_and_belongs_to_many :countries, join_table: :post_countries
  has_many :post_sections_posts
  has_many :post_sections, through: :post_sections_posts

  has_many :authors_posts
  has_many :authors, through: :authors_posts

  has_many :email_alerts_posts
  has_many :email_alerts, through: :email_alerts_posts

  validates :headline, :byline, length: { maximum: 255 }
  validates :cover_description, length: { maximum: 1_000 }
  validates :headline, :content, presence: true
  validates :cover, file_size: { maximum: 15.megabytes }
  validates :content, length: { maximum: 100_000 }

  validates :published_at, presence: true, if: -> { self.published }

  validate :one_author_at_least
  validate :one_country_at_least

  mount_uploader :cover, PostCoverUploader
  mount_uploader :video_mp4, VideoMp4Uploader
  mount_uploader :video_webm, VideoWebmUploader

  scope :latest,              -> { order('published_at DESC') }
  scope :published,           -> { where(published: true).where.not(published_at: nil).where('published_at < ?', Time.zone.now) }
  scope :authors_pick,        -> { where(authors_pick: true) }
  scope :breaking_news,       -> { where(is_breaking_news: true) }
  scope :with_image,          -> { where.not(cover: nil) }
  scope :digest,       -> { where(in_digest: true) }
  scope :outdated,            -> { where('published_at < :outdated_date', outdated_date: 3.days.ago) }
  scope :in_carousel,         -> { where(in_carousel: true).order(published_at: :desc) }

  scope :featured,            -> (level=1) { where(featured_level: level)}
  scope :ranked,              -> { rank(:rank) }

  scope :last_week,           -> { where('published_at >= :date', date: 1.week.ago) }
  scope :last_day,            -> { where('published_at >= :date', date: 1.day.ago) }
  scope :by_views,            -> { order('views DESC') }
  scope :in_ticker,           -> { where(in_ticker: true) }

  class << self
    def pageviews
      Impression.where(impressionable_type: 'Post').where.not(impressionable_id: nil).count
    end

    def unique_visitors
      Impression.select(:session_hash).where(impressionable_type: 'Post').distinct.count
    end
  end

  def to_s
    self.headline
  end

  def sections_names
    post_sections.pluck(:name).join(', ')
  end

  def pageviews(range_params)
    impressionist_count(range_params)
  end

  def unique_visitors(range_params)
    impressionist_count(range_params.merge({ filter: :session_hash }))
  end

  def author_names
    self.authors.map { |p| p.name }.join(', ')
  end

  def countries_names
    countries.map(&:name).join(', ')
  end

  def headline_with_alerted_mark
    # "#{self.headline} #{self.automatic_email_alerts.count > 0 ? '<b>(alerted with auto mailing)</b>' : ''}".html_safe
    "#{self.headline} #{self.email_alerts.count > 0 ? '<b>(alerted with auto mailing)</b>' : ''}".html_safe
  end

  def visible_for?(user)
    if user.nil?
      self.green? || (self.yellow? && self.published_at <= 2.days.ago) || (self.red? && self.published_at <= 7.days.ago)
    else
      true
    end
  end

  protected

  def one_author_at_least
    if authors.size == 0
      errors.add(:authors, 'You need to add at least one author')
    end
  end

  def one_country_at_least
    if countries.size == 0
      errors.add(:countries, 'You need to add at least one country')
    end
  end


  def set_published_at
    if published && !published_at
      self.published_at = Time.zone.now
    end
  end

  def slug_source
    [headline, rand(10_000) + 100]
  end
end
