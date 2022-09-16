class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :name
      t.integer :fueltype
      t.integer :bodytype
      t.integer :gearbox
      t.integer :price
      t.references :model, null: false, foreign_key: true
      t.references :dealer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
