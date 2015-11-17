class CreateOutflows < ActiveRecord::Migration
  def change
    create_table :outflows do |t|
      t.decimal :value, :precision => 13, :scale => 2
      t.date :flowDate
      t.text :concept

      t.timestamps
    end
  end
end
