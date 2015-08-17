class ChangeSslorgToSllorg < ActiveRecord::Migration
  def change
    rename_column :oppties, :sslOrg, :sllOrg
  end
end
