class CreateRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :rentals do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.string :state, default: 'rented'
      t.datetime :return_at, null: false
      t.datetime :returned_at

      t.timestamps
    end
  end
end
