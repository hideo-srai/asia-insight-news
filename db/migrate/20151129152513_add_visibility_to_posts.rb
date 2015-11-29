class AddVisibilityToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :visibility, :string
  end
end
