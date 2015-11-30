class CreateAutomaticEmailAlertsPosts < ActiveRecord::Migration
  def change
    create_table :automatic_email_alerts_posts do |t|
      t.references :automatic_email_alert
      t.references :post

      t.timestamps
    end
  end
end
