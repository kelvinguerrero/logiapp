class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.references :outflow, index:true
      t.references :dispatch, index:true

      t.boolean :lastChange, default: true
      t.string :saleDescription
      t.integer :saleType

      t.timestamps
    end
  end
end
