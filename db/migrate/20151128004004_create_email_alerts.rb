class CreateEmailAlerts < ActiveRecord::Migration
  def change
    create_table :email_alerts do |t|
      t.text     "user_groups"
      t.string   "status",           default: "initial"
      t.datetime "alert_at"
      t.text     "greeting_message", default: ""
      t.string   "subject"

      t.timestamps
    end
  end
end
