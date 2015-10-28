class AddPublishedToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :published, :boolean, default: false
  end
end
