class CreateOppties < ActiveRecord::Migration
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
      t.integer :valid
      t.integer :numWriters

      t.timestamps
    end
  end
end
