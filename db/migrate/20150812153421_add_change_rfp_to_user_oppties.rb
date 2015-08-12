class AddChangeRfpToUserOppties < ActiveRecord::Migration
  def change
    add_column :user_oppties, :changeRFP, :boolean
  end
end
