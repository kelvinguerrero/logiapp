class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.integer :consecutiveNumber
      t.date :movementDate
      t.decimal :value, :precision => 13, :scale => 2
      t.text :concept
      t.belongs_to :logi_bill, index:true
      t.belongs_to :type_movement, index:true

      t.timestamps
    end
  end
end
