class AddSlDirLeadEstimEngagedSolutionEstimateToOppties < ActiveRecord::Migration
  def change
    add_column :oppties, :slDir, :string
    add_column :oppties, :leadEstim, :string
    add_column :oppties, :engaged, :string
    add_column :oppties, :solution, :string
    add_column :oppties, :estimate, :string
  end
end
