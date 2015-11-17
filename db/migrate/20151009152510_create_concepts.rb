class CreateConcepts < ActiveRecord::Migration
  def change
    create_table :concepts do |t|
      t.text :container
      t.text :description
      t.text :route
      t.decimal :total, :precision => 13, :scale => 2

      t.belongs_to :invoice, index:true

      t.timestamps
    end
  end
end
