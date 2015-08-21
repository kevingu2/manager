class RemoveadFromNotifications < ActiveRecord::Migration
  def change
  	remove_column :notifications, :ad, :string
  end
end
