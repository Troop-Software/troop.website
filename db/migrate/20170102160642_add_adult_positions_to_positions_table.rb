class AddAdultPositionsToPositionsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :positions, :adult_position, :boolean, default: false
    add_column :positions, :bsa_code, :string
    add_column :positions, :short_code, :string
  end
end
