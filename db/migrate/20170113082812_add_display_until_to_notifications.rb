class AddDisplayUntilToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :display_until, :date
  end
end
