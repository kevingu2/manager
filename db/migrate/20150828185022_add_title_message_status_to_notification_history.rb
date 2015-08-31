class AddTitleMessageStatusToNotificationHistory < ActiveRecord::Migration
  def change
    add_column :notification_histories, :status, :integer
    add_column :notification_histories, :title, :string
    add_column :notification_histories, :message, :string
  end
end
