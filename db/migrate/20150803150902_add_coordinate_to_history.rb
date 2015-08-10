class AddCoordinateToHistory < ActiveRecord::Migration
  def change
    add_column :histories, :coordinate, :string
  end
end
