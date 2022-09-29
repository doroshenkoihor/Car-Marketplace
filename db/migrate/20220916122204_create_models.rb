class CreateModels < ActiveRecord::Migration[7.0]
  def change
    create_table :models do |t|
      t.string :name
      t.integer :cars_count, default: 0
      t.text :description
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
