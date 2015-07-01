class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :opptyName
      t.string :opptyId
      t.references :oppty, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
