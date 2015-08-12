class AddPublishedAtToLink < ActiveRecord::Migration
  def change
    add_column :links, :published_at, :datetime
  end
end
