class BlogPost < ActiveRecord::Base
  include Concerns::Sluggable
  self.per_page = 20

  has_and_belongs_to_many :countries

  validate :one_country_at_least

  scope :latest,              -> { order('published_at DESC') }

  mount_uploader :cover, PostCoverUploader

  def countries_names
    countries.map(&:name).join(', ')
  end

  protected

  def slug_source
    [headline, rand(10_000) + 100]
  end

  def one_country_at_least
    if countries.size == 0
      errors.add(:countries, 'You need to add at least one country')
    end
  end
end
