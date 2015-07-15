class ChangeIntsToFloatsForOppties < ActiveRecord::Migration
  def change
    change_column :oppties, :pWin,:float
    change_column :oppties, :pBid,:float
    change_column :oppties, :awardFV,:float
    change_column :oppties, :saicvaPercent,:float
    change_column :oppties, :saicva,:float
    change_column :oppties, :mat,:float
    change_column :oppties, :materialsTV,:float
    change_column :oppties, :subc,:float
    change_column :oppties, :subTV,:float
    change_column :oppties, :cg_va,:float
    change_column :oppties, :sss_va,:float
    change_column :oppties, :nwi_va,:float
    change_column :oppties, :hwi_va,:float
    change_column :oppties, :itms_va,:float
    change_column :oppties, :tss_va,:float
    change_column :oppties, :ccds_va,:float
    change_column :oppties, :mss_va,:float
    change_column :oppties, :swi_va,:float
    change_column :oppties, :lsc_va,:float
    change_column :oppties, :zzOth_va,:float
    change_column :oppties, :pri,:float
    change_column :oppties, :fy16PreBP,:float
    change_column :oppties, :fy16PreBPSpent,:float
    change_column :oppties, :fy16PreBPSpentPercent,:float
    change_column :oppties, :fy16BDTot,:float
    change_column :oppties, :fy16BDTotSpent,:float
    change_column :oppties, :fy16BDTotSpentPercent,:float
    change_column :oppties, :fy16BP,:float
    change_column :oppties, :fy16BPSpent,:float
    change_column :oppties, :fy16PreBPSpentPercent,:float
  end
end
