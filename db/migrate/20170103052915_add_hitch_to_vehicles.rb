class AddHitchToVehicles < ActiveRecord::Migration[5.0]
  def change
    add_column :vehicles, :hitch, :boolean, default: false
  end
end
