class DropAllocatedTasksTable < ActiveRecord::Migration
  def change
	drop_table :allocated_tasks
  end
end
