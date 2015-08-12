class ChangePostCountryToCountryId < ActiveRecord::Migration
  def up
    remove_column :posts, :country
    add_column :posts, :country_id, :integer

    add_index :posts, :country_id
  end

  def down
    remove_column :posts, :country_id
    add_column :posts, :country, :string
  end
end
