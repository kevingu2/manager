class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :oppties, :sslArch, :slArch
  end
end
