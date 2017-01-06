class DropLatLongFromEventLocation < ActiveRecord::Migration[5.0]
  def change
    remove_column :event_locations, :latitude
    remove_column :event_locations, :longitude
  end
end
