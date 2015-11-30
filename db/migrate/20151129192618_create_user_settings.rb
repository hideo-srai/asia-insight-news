class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.references :user
      t.boolean :email_alerts, default: true
      t.boolean :cookie, default: true

      t.timestamps
    end
  end
end
