class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :ad
      t.integer :oppty_id
      t.integer :user_id
      t.string :title
      t.string :message
      t.datetime :created_at

      t.timestamps
    end
  end
end
