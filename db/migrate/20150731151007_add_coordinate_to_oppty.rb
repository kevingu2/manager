class AddCoordinateToOppty < ActiveRecord::Migration
  def change
    add_column :oppties, :coordinate, :string
  end
end
