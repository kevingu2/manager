class AddUseridOpptyIdToNotificationHistory < ActiveRecord::Migration
  def change
    add_column :notification_histories, :user_id, :integer
    add_column :notification_histories, :history_id, :integer
  end
end
