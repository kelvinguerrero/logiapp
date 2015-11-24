class AddConceptToBillMovements < ActiveRecord::Migration
  def change
    add_column :bill_movements, :concept, :text
  end
end
