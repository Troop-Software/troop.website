class CreateAdultVehicle < ActiveRecord::Migration[5.0]
  def change
    create_table :adult_vehicles do |t|
      t.references :adult, foreign_key: true
      t.references :vehicle, foreign_key: true
    end
  end
end
