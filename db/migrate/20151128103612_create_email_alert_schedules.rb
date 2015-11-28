class CreateEmailAlertSchedules < ActiveRecord::Migration
  def change
    create_table :email_alert_schedules do |t|
      t.text     "user_groups"
      t.datetime "send_at"
      t.text     "greeting_message"
      t.string   "days_of_week"

      t.timestamps
    end
  end
end
