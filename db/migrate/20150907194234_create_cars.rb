class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :plate
      t.string :model
      t.string :color
      t.belongs_to :driver, index:true
      t.timestamps
    end
  end
end
