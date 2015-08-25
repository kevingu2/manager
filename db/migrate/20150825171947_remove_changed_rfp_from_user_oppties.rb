class RemoveChangedRfpFromUserOppties < ActiveRecord::Migration
  def change
    remove_column :user_oppties, :changeRFP, :boolean
  end
end
