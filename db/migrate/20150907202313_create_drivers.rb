class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :lastName
      t.boolean :blacklist, default: false
      t.boolean :busy, default: false
      t.text :blacklistComment
      t.column :document, :bigint
      t.column :cellPhone, :bigint

      t.timestamps
    end
  end
end
