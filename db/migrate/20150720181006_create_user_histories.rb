class CreateUserHistories < ActiveRecord::Migration
  def change
    create_table :user_histories do |t|
      t.references :history, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
