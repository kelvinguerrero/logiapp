class CreateNavies < ActiveRecord::Migration
  def change
    create_table :navies do |t|
      t.string :name
      t.timestamps
    end
  end
end
