class CreateCentralBanks < ActiveRecord::Migration
  def change
    create_table :central_banks do |t|
      t.string :bank_name
      t.string :bank_link
      t.string :policy_target
      t.string :current_settings
      t.string :change
      t.string :next_policy_announcement
      t.string :report_name
      t.string :report_link
      t.string :change_expected

      t.timestamps
    end
  end
end
