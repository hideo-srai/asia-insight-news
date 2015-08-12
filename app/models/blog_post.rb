class BlogPost < ActiveRecord::Base
  include Concerns::Sluggable
  self.per_page = 20

  scope :latest,              -> { order('published_at DESC') }

  mount_uploader :cover, PostCoverUploader
  protected
  def slug_source
    [headline, rand(10_000) + 100]
  end
end
