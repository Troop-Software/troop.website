class CreateEventLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :event_locations do |t|
      t.string :line1
      t.string :line2
      t.string :city
      t.string :state
      t.string :zip
      t.integer :type
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
