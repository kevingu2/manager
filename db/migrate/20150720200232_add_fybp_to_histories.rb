class AddFybpToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :fy16BP, :float
    add_column :histories, :fy16BPSpent, :float
    add_column :histories, :fy16BPSpentPercent, :float
  end
end
