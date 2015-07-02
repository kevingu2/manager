class AddStatusToUserOppties < ActiveRecord::Migration
  def change
    add_column :user_oppties, :status, :Integer, default:0
  end
end
