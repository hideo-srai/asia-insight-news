class Chart < ActiveRecord::Base
  validates :description, length: { maximum: 5_000 }

  mount_uploader :image, ChartImageUploader
end