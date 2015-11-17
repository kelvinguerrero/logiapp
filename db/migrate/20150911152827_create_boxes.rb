class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :name
      t.decimal :value, :precision => 13, :scale => 2
      t.decimal :total, :precision => 13, :scale => 2
      t.date :incomeDate
      t.belongs_to :outflow, index:true
      t.belongs_to :movement, index:true

      t.timestamps
    end
  end
end
