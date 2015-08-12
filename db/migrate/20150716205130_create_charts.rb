class CreateCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
      t.string :image
      t.text :description

      t.timestamps
    end
  end
end
