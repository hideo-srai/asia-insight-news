class CreatePdfEmailAlerts < ActiveRecord::Migration
  def change
    create_table :pdf_email_alerts do |t|
      t.string   "file"
      t.string   "user_groups"
      t.text     "greeting_message"
      t.string   "status"

      t.timestamps
    end
  end
end
