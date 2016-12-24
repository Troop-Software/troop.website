class AddIndexToScoutPosition < ActiveRecord::Migration[5.0]
  def change
    add_index :scout_positions, [:scout_id, :position_id, :start_date], unique: true, name: :unique_entry
  end
end
