class ChangeIntsToFloatsForHistories < ActiveRecord::Migration
  def change
    change_column :histories, :pWin,:float
    change_column :histories, :pBid,:float
    change_column :histories, :awardFV,:float
    change_column :histories, :saicvaPercent,:float
    change_column :histories, :saicva,:float
    change_column :histories, :mat,:float
    change_column :histories, :materialsTV,:float
    change_column :histories, :subc,:float
    change_column :histories, :subTV,:float
    change_column :histories, :cg_va,:float
    change_column :histories, :sss_va,:float
    change_column :histories, :nwi_va,:float
    change_column :histories, :hwi_va,:float
    change_column :histories, :itms_va,:float
    change_column :histories, :tss_va,:float
    change_column :histories, :ccds_va,:float
    change_column :histories, :mss_va,:float
    change_column :histories, :swi_va,:float
    change_column :histories, :lsc_va,:float
    change_column :histories, :zzOth_va,:float
    change_column :histories, :pri,:float
    change_column :histories, :fy16PreBP,:float
    change_column :histories, :fy16PreBPSpent,:float
    change_column :histories, :fy16PreBPSpentPercent,:float
    change_column :histories, :fy16BDTot,:float
    change_column :histories, :fy16BDTotSpent,:float
    change_column :histories, :fy16BDTotSpentPercent,:float
    change_column :histories, :fy16BP,:float
    change_column :histories, :fy16BPSpent,:float
    change_column :histories, :fy16PreBPSpentPercent,:float
  end
end
