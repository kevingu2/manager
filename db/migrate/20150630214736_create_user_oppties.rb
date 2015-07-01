class CreateUserOppties < ActiveRecord::Migration
  def change
    create_table :user_oppties do |t|
      t.references :oppty, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
