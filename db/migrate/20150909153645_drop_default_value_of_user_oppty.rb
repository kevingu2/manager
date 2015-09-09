class DropDefaultValueOfUserOppty < ActiveRecord::Migration
  def change
    change_column_default(:user_oppties,:status, nil)
  end
end
