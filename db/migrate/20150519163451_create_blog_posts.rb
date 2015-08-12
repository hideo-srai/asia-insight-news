class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :cover
      t.string :headline
      t.text :readout
      t.text :content
      t.string :slug
      t.datetime :published_at
      t.timestamps
    end
  end
end
