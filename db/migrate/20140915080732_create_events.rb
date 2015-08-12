class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :data_for
      t.integer :country_id

      t.date :date
      t.time :time_local
      t.time :time_gmt

      t.timestamps
    end

    add_index :events, :country_id
  end
end
