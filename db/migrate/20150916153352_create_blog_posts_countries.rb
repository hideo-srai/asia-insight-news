class CreateBlogPostsCountries < ActiveRecord::Migration
  def change
    create_table :blog_posts_countries do |t|
      t.references :blog_post, index: true
      t.references :country, index: true
    end
  end
end
