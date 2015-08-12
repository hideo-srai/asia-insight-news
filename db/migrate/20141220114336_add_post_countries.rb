class AddPostCountries < ActiveRecord::Migration
  def up
    remove_column :posts, :country_id

    create_table :post_countries do |t|
      t.references :post
      t.references :country
    end
  end

  def down
    drop_table :post_countries

    add_column :posts, :country_id, :integer
    add_index :posts, :country_id
  end
end
