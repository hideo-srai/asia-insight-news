class AddFlagUrlToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :flag_url, :string
  end
end
