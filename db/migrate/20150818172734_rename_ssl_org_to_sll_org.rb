class RenameSslOrgToSllOrg < ActiveRecord::Migration
  def change
    rename_column :histories, :sslOrg, :sllOrg
  end
end
