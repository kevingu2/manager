class AddnewNotifCountToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :new_notif_count, :integer
  end
end
