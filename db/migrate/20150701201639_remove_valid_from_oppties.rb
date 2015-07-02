class RemoveValidFromOppties < ActiveRecord::Migration
  def change
    remove_column :oppties, :valid, :integer
  end
end
