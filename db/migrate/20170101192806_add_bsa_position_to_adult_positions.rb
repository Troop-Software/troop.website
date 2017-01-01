class AddBsaPositionToAdultPositions < ActiveRecord::Migration[5.0]
  def change
    add_column :adult_positions, :bsa_position, :boolean, default: false
  end
end
