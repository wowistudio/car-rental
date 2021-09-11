class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :uid, null: false
      t.string :membership, null: false

      t.timestamps
    end
  end
end
