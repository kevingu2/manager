class AddnewNotifCountDefaultValueToUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :new_notif_count, :integer
  end
end
