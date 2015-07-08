class ResetOppties < ActiveRecord::Migration
  def change
    create_table :oppties do |t|
      t.string :opptyId
      t.string :opptyName
      t.string :idiqCA
      t.string :status2
      t.float :value
      t.integer :pWin
      t.string :captureMgr
      t.string :programMgr
      t.string :proposalMgr
      t.string :sslOrg
      t.string :technicalLead
      t.string :sslArch
      t.string :ed
      t.string :on
      t.string :ate
      t.string :slComments
      t.date :rfpDate
      t.date :awardDate
      t.date :submitDate
      t.boolean :done, default:false
      t.date :proposalDueDate
      t.string :slDir
      t.string :leadEstim
      t.string :engaged
      t.string :solution
      t.string :estimate

      t.timestamps
      end
  end
end
