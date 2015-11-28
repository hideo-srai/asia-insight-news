class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :company, :string
    add_column :users, :title, :string
    add_column :users, :country, :string
    add_column :users, :user_group, :string
    add_column :users, :previous_user_group, :string
    add_column :users, :user_group_changed_at, :datetime
    add_column :users, :expires_at, :datetime
  end
end
