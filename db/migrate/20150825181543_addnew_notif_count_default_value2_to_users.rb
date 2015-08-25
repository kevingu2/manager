class AddnewNotifCountDefaultValue2ToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :new_notif_count, :integer, default: 0
  end
end
