class CreateMiddlemen < ActiveRecord::Migration
  def change
    create_table :middlemen do |t|
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
