class AddChangedAtToCentralBank < ActiveRecord::Migration
  def change
    add_column :central_banks, :changed_at, :date
  end
end
