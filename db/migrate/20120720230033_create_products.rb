class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.string :location
      t.string :seller

      t.timestamps
    end
  end
end
