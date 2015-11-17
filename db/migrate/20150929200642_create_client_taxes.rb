class CreateClientTaxes < ActiveRecord::Migration
  def change
    create_table :client_taxes do |t|
      t.string :name
      t.boolean :iva
      t.boolean :reteica
      t.boolean :retefuente

      t.timestamps
    end
  end
end
