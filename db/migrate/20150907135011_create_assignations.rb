class CreateAssignations < ActiveRecord::Migration
  def change
    create_table :assignations do |t|
      t.string :shipment
      t.integer :quantity
      t.integer :released
      t.string :workOrder
      t.decimal :price, :precision => 13, :scale => 2
      t.date :startDate
      t.date :endDate
      t.belongs_to :navy, index:true
      t.belongs_to :container, index:true
      t.belongs_to :way, index:true
      t.timestamps
    end
  end
end