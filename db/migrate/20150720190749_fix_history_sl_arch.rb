class FixHistorySlArch < ActiveRecord::Migration
  def change
    rename_column :histories, :sslArch, :slArch
  end
end
