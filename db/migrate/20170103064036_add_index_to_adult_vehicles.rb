class AddIndexToAdultVehicles < ActiveRecord::Migration[5.0]
  def change
    add_index :adult_vehicles, [:adult_id, :vehicle_id], unique: true, name: :adult_to_vehicle
  end
end
