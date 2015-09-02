class CreateNotificationHistories < ActiveRecord::Migration
  def change
    create_table :notification_histories do |t|

      t.timestamps
    end
  end
end
