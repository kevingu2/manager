class AddDoneToOppties < ActiveRecord::Migration
  def change
    add_column :oppties, :done, :boolean, default: false
  end
end
