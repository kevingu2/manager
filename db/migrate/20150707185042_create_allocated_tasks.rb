class CreateAllocatedTasks < ActiveRecord::Migration
  def change
    create_table :allocated_tasks do |t|
      t.string :title
      t.string :taskId
      t.text :comment

      t.timestamps
    end
  end
end
