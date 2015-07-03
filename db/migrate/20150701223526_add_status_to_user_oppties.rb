class AddStatusToUserOppties < ActiveRecord::Migration
  def change
    add_column :user_oppties, :status, :Integer, default:2
  end
end
