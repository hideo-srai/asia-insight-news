class CreateAutomaticEmailAlerts < ActiveRecord::Migration
  def change
    create_table :automatic_email_alerts do |t|
      t.references :email_alert_schedule
      t.timestamps
    end
  end
end
