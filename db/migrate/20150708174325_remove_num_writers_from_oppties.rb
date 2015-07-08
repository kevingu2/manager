class RemoveNumWritersFromOppties < ActiveRecord::Migration
  def change
    remove_column :oppties, :numWriters, :integer
  end
end
