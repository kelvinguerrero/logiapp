class CreateTypeMovements < ActiveRecord::Migration
  def change
    create_table :type_movements do |t|
      t.string :name

      t.timestamps
    end
  end
end
