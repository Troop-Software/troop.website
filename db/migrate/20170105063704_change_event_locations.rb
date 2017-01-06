class ChangeEventLocations < ActiveRecord::Migration[5.0]
  def change
    rename_column :event_locations, :line1, :name
    rename_column :event_locations, :line2, :street
  end
end
