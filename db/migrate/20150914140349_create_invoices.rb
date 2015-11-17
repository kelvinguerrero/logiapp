class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.decimal :total
      t.decimal :subtotal
      t.decimal :iva
      t.decimal :retefuente
      t.decimal :reteica
      t.boolean :paid, :default => false
      t.integer :idcontable
      t.integer :workorder
      t.integer :quantity
      t.date :expirationDate
      t.date :elaborationDate
      t.date :eradicateDate
      t.belongs_to :assignation, index:true
      t.belongs_to :client_tax, index:true

      t.timestamps
    end
  end
end
