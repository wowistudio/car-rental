class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.references :rental, null: false, foreign_key: true
      t.float :balance, default: 0

      t.timestamps
    end
  end
end
