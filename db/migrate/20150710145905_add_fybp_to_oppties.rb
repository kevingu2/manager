class AddFybpToOppties < ActiveRecord::Migration
  def change
    add_column :oppties, :fy16BP, :integer
    add_column :oppties, :fy16BPSpent, :integer
    add_column :oppties, :fy16BPSpentPercent, :integer
  end
end
