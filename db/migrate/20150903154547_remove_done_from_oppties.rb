class RemoveDoneFromOppties < ActiveRecord::Migration
  def change
    remove_column :oppties, :done
  end
end
