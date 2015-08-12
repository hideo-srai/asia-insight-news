class RecreatePostCoverPdfVersion < ActiveRecord::Migration
  def up
    Post.all.each do |post|
      post.cover.recreate_versions!(:pdf) if post.cover.path
    end
  end
end
