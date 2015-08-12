class RecreateAuthorPhotoThumb < ActiveRecord::Migration
  def change
    Author.all.each do |author|
      author.photo.recreate_versions!(:thumb) if author.photo.path
    end
  end
end
