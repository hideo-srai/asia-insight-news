class Country < ActiveRecord::Base
  include Concerns::Sluggable
  validates :name, presence: true, length: { maximum: 255 }


  protected

  def slug_source
    self.name
  end
end
