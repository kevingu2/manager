class RemoveOpptynameOpptyIdFromHistories < ActiveRecord::Migration
  def change
    remove_column :histories, :opptyName, :String
    remove_column :histories, :opptyId, :String
  end
end
