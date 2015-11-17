class CreateDispatches < ActiveRecord::Migration
  def change
    create_table :dispatches do |t|
      t.column :manifestNumber,:bigint
      t.column :loadOrder, :bigint
      t.decimal :advance
      t.decimal :balance

      t.date :deliverDate
      t.date :downloadDate
      t.date :advanceDate

      t.date :paymentBalanceDate
      t.date :completeDate

      t.boolean :balancePay
      t.string :loadConcept
      t.boolean :unoccupied
      t.string :containerNumber

      t.belongs_to :assignation, index:true
      t.belongs_to :car, index:true
      t.belongs_to :driver, index:true
      t.belongs_to :middleman, index:true
      t.belongs_to :invoice, index:true

      t.timestamps
    end
  end
end
