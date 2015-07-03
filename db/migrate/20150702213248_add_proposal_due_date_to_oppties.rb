class AddProposalDueDateToOppties < ActiveRecord::Migration
  def change
    add_column :oppties, :proposalDueDate, :date
  end
end
