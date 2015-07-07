class AddSlDirLeadEstimEngagedSolutionEstimateToOppties < ActiveRecord::Migration
  def change
    add_column :oppties, :slDir, :String
    add_column :oppties, :leadEstim, :String
    add_column :oppties, :engaged, :String
    add_column :oppties, :solution, :String
    add_column :oppties, :estimate, :String
  end
end
