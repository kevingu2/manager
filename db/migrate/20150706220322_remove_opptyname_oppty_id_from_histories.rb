class RemoveOpptynameOpptyIdFromHistories < ActiveRecord::Migration
  def change
    remove_column :histories, :opptyName, :string
    remove_column :histories, :opptyId, :string
  end
end
