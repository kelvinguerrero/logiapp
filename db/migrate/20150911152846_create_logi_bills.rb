class CreateLogiBills < ActiveRecord::Migration
  def change
    create_table :logi_bills do |t|
      t.string :name
      t.integer :endNumber

      t.timestamps
    end
  end
end
