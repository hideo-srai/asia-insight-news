class CreateSalesManagers < ActiveRecord::Migration
  def change
    create_table :sales_managers do |t|
      t.string   "email"
      t.string   "name"
      t.boolean  "email_registrants", default: true
      t.boolean  "trial_registrants", default: true

      t.timestamps
    end
  end
end
