class CreateBillMovements < ActiveRecord::Migration
  def change
    create_table :bill_movements do |t|
      t.references :logi_bill, index:true
      t.references :bill_movement, index:true
      t.references :type_movement, index:true
      t.boolean :lastChange, default: true

      t.decimal :total, :precision => 13, :scale => 2
      t.decimal :value, :precision => 13, :scale => 2

      t.timestamps
    end
  end
end
