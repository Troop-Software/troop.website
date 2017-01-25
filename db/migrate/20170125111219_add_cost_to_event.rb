class AddCostToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :cost, :decimal, :precision => 8, :scale => 2
  end
end
